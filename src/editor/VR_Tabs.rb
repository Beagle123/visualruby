
class VR_Tabs < Gtk::Notebook

  attr_reader :docs  

  include VR_TabSearch

  def initialize(main)
    super()
    @docs = []
    @main = main
    @x_img = File.dirname(__FILE__) + '/../../img/close.png'
    self.scrollable = true #after super
    self.expand = true
  end

#todo update file tree, parent window?
  def save_as()  # returns false or complete file name.
    dialog = Gtk::FileChooserDialog.new(
              title: "Save File As...",
              parent: @main.builder[:window1],
              action: :save,
              buttons: [["_Cancel", :cancel], ["_Save", :accept]])
    dialog.current_folder = File.dirname(@docs[page].full_path_file)
    dialog.current_name = VR_Document.get_class_title(@docs[page].buffer.text) 
    resp = dialog.run 
    dialog.hide
    if resp == :accept
      @docs[page].write_to_disk(dialog.filename)
      destroy_tab()
      clear_events
      load_tab(dialog.filename)
      clear_events
      @main.file_tree.refresh()
      return true
    end 
    return false
  end
 
  def save_changes?
    answer = alert("Save chages to:  <b> #{File.basename(@docs[page].full_path_file)}</b> ?",
              button_yes: "Save Changes", button_no: "Discard Changes",  
              headline: "Save Changes?", button_cancel: "Cancel")
    if answer == true # save
      if @docs[page].title.label == "Untitled"
        return save_as() 
      else
        return @docs[page].write_to_disk()
      end      
    elsif answer == false # Discard Changes
      @docs[page].reload_from_disk()
      return true #continue without saving
    end
    return false #abort!  
  end
  
  def try_to_save(ask = true)
#    return false if not @docs[page].modified_time_matches()
    return true if @docs[page].empty?
    if (@docs[page].title.label == "Untitled") or (@docs[page].buffer.modified? and ask)  
      return save_changes? 
    end
    if @docs[page].buffer.modified?
      @docs[page].write_to_disk()
    end
    return true   
  end


  def update_style_all()
    @docs.each { |doc| doc.update_style() }
  end

  def modified_times_ok()
    answers = @docs.each.collect { |doc| doc.modified_time_matches }
    return !answers.include?(false)
  end

  # Tries to save and/or close all open documents
  # @param [Hash] flags Optiions
  # @option [Boolean] ask Whether or not to ask to save or save without asking.
  # @option [Boolean] close Close tab when finished 
  def try_to_save_all(flags)
    start_page = self.page
    return false unless modified_times_ok()  
    passed = true 
    (0..n_pages-1).each do |i|
      self.page = i
      unless try_to_save(flags[:ask])
        passed = false
      end
    end
    if flags[:close] 
      (n_pages).times { destroy_tab() } 
    else
      self.page = start_page
    end
    return passed  
  end

 
  def switch_to(path)
    i = tab_number(path)
    return false if i.nil?  
    self.page = i if i != self.page
    return true
  end  

  def set_contents(text)
    if @docs[self.page].buffer.text == ""
      @docs[self.page].buffer.text = text
      @docs[self.page].buffer.modified = false
    end
  end

  def load_tab(full_path_file = Dir.pwd + "/Untitled")
    return if switch_to(full_path_file) 
    return unless File.exist?(full_path_file) or full_path_file == Dir.pwd + "/Untitled"
    box = Gtk::EventBox.new
    tab = Gtk::Box.new(:horizontal)
    img = Gtk::Image.new(:file => @x_img)
    box.add(img)
    title = Gtk::Label.new(File.basename(full_path_file))
    tab.pack_start(title, :expand=>true, :fill=>true, :padding=>2)
    tab.pack_start(box)
    tab.show_all #needed
    text = VR_Document.new(full_path_file, title, @main)
    child = Gtk::ScrolledWindow.new
    child.add(text)
    box.signal_connect("button_release_event") {remove_id(text.object_id)}
    #remove blank tab
    if @docs.size == 1 and @docs[0].buffer.text.strip == "" 
      @docs[0] = text
      self.remove_page(0)
    end
    child.show_all #needed
    append_page(child, tab)  
    self.page = self.n_pages - 1
    @docs[self.page] = text
  end  
  
  #used when little 'x' image is clicked to close.
  def remove_id(object_id)
    i = @docs.index { |doc| doc.object_id == object_id }
    page = i
    clear_events
    if try_to_save(true)
      destroy_tab(i) 
    end
  end
  
  #if its there, destroys it
  def destroy_file_tab(file_name)
    destroy_tab tab_number(file_name)
  end

  def tab_number(file_name)
    @docs.index{ |d| d.full_path_file == file_name}    
  end

# this spits out a bunch of warnings on remove_page.  Changing the page number
# stops the warnings.
  def destroy_tab(tab = self.page)
    return unless tab
    self.page = self.page - 1 # stops some warnings
#    self.page = -1
#alert "1"
#alert "before"
    self.get_nth_page(tab).destroy
    clear_events
#alert "during"
#    self.remove_page(tab)  # causes warinings nothing I can do!
    clear_events
#alert "after"
    @docs.delete_at(tab)

#    self.set_tab_label(get_nth_page(tab), nil)   
    load_tab() if @docs.empty?

  end

  def get_open_fn()
    @docs.inject([]) { |ar, doc| ar << doc.full_path_file }
  end

  def open_file_names(ar)
   ar.each { |fn| load_tab(fn) if File.file?(fn) and fn.include? Dir.pwd}
   load_tab() if @docs.empty?
  end

end
