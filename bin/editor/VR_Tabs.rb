
class VR_Tabs < Gtk::Notebook

  attr_reader :docs  

	include VR_TabSearch

  def initialize(main)
    super()
    @docs = Array.new
    @main = main
    @pix_close = Gdk::Pixbuf.new(File.dirname(__FILE__) + '/../../img/close.png')
		@close_filename = File.dirname(__FILE__) + '/../../img/close.png'
		self.scrollable = true #after super
		self.expand = true
  end

	def update_style_all()
		@docs.each { |doc| doc.update_style() }
	end

	def try_to_save_all(flags)
		ask = flags[:ask]
		passed = true 
		@docs.each do |doc|
			unless doc.try_to_save(ask)
				passed = false
			end
		end	
		(n_pages).times { destroy_tab() }	if flags[:close]
		return passed	
	end

##todo update file_tree!
#	def try_to_save_all(ask = true)
#		@docs.each do |doc|
#			return false unless doc.try_to_save(ask)
#		end
#	end
#
##todo update file_tree!
#	def try_to_close_all(ask = true)
#		return false unless try_to_save_all(ask)
#		(n_pages).times { destroy_tab() }
#	end


  def switch_to(path)
		i = @docs.index{ |d| d.full_path_file == path }
		return false if i.nil? 
		self.page = i if i != self.page
    @docs[self.page].show_all
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
		box = Gtk::EventBox.new
		tab = Gtk::Box.new(:horizontal)
		img = Gtk::Image.new(:pixbuf => @pix_close)
		box.add(img)
		title = Gtk::Label.new(File.basename(full_path_file))
		tab.pack_start(title, :expand=>true, :fill=>true, :padding=>2)
		tab.pack_start(box)
		tab.show_all
		text = VR_Document.new(full_path_file, title, @main)
		child = Gtk::ScrolledWindow.new
		child.add(text)
    child.show_all
		box.signal_connect("button_release_event") {remove_id(text.object_id)}
		#remove blank tab
		if @docs.size == 1 and @docs[0].buffer.text.strip == "" 
			@docs[0] = text
			self.remove_page(0)
		end
 		append_page(child, tab)
    self.show_all			
		self.page = self.n_pages - 1
		@main.builder['boxTabs'].show_all # needed
		@docs[self.page] = text
	end	
	
	#used when little 'x' image is clicked to close.
	def remove_id(object_id)
		i = @docs.index { |doc| doc.object_id == object_id }
		if @docs[i].try_to_save(true)
			destroy_tab(i) 
		end
	end
	
	#if its there, destroys it
	def destroy_file_tab(file_name)
		destroy_tab() if switch_to(file_name)
	end

	def destroy_tab(tab = self.page)
  	@docs.delete_at(tab)
		self.set_tab_label(get_nth_page(tab), nil)
  	self.remove_page(tab)
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
