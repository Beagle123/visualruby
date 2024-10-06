
class VR_File_Tree < VR::FileTreeView 

  def initialize(main, icon_path)
    super(Dir.pwd,icon_path)
    @main = main
    @api = RubygemsAPI.new
    @builder = Gtk::Builder.new(file: File.join(File.dirname(__FILE__), "glade", "VR_File_Tree.glade"))
    @builder.connect_signals{ |handle| method(handle) }
  end

  def self__row_activated(*args)  
    return unless rows = selected_rows
    file_name = rows.first[:path]
    basename = File.basename(file_name)
    ext = File.extname(file_name)
    if ext == ".glade"
      Open3.popen3("#{$VR_ENV_GLOBAL.glade_path} #{file_name} ")
    elsif ext == ".gem"
      if alert("Do you want to install <b>#{basename}</b>?", parent: @main, button_cancel: "Cancel")
        popInstallGem_clicked    
      end
    elsif File.directory?(file_name)  
      expand_or_collapse_folder()
    else
      @main.tabs.load_tab(file_name)     
    end
  end


  def popPushGem_clicked
    file_name = get_selected_path() 
    @main.shell.buffer.text = @api.push_gem(file_name)  
  end

  def popInstallGem_clicked()
    file_name = get_selected_path().to_s
    begin
      txt = "\nInstalled Gem:  " + file_name
      package = Gem::Package.new(file_name)
      inst = Gem::Installer.new(package, wrappers: true, ignore_dependencies: true)
      inst.install
      txt += "\nNo check was made for dependencies"
    rescue Exception => e
      txt += "\n" + e.message.to_s
    end
    @main.shell.buffer.text = txt
  end


  def popBuildGem_clicked
    file_name = get_selected_path()
    root = File.dirname(file_name)
    unless root == Dir.pwd
      alert("You must create gems from the root folder.")
      return
    end
    @main.tabs.try_to_save_all(:ask => false)
    gem_builder = "Loading .gemspec file:  " + file_name + "\n"
    begin 
      Gem::Specification.reset
      spec = Gem::Specification.load(file_name)
      gem_file_name = Gem::Package.build(spec)
      gem_builder = gem_builder + "Built Gem:  " + gem_file_name + "\n"
      gem_path = File.join(root, gem_file_name)
      add_file(gem_path) if File.exist?(gem_path)
    rescue
      gem_builder = gem_builder + "Error: " + gem_file_name.to_s
    end
    @main.shell.buffer.text = gem_builder          
  end

  def popGlade_clicked
    path = get_selected_path()
    source_code = File.open(path, "r").read
    class_name = VR_Document.get_class_title(source_code).gsub(".rb", "")
    glade_file = File.dirname(path) + "/glade/" + class_name + ".glade" 
    if not File.file?(glade_file)
      path = File.dirname(glade_file)
      FileUtils.makedirs(path) if not File.directory?(path)
      blank_glade = File.expand_path(File.dirname(__FILE__)+"/../../skeleton/document/New.glade") 
      FileUtils.cp blank_glade, glade_file
      Open3.popen3("#{$VR_ENV_GLOBAL.glade_path} #{glade_file}")
    else
      Open3.popen3("#{$VR_ENV_GLOBAL.glade_path} #{glade_file}")
    end
  end

  def self__button_release_event(w, event)          # right click
    return unless path = get_selected_path() and event.button == 3
    if File.file?(path) and (File.extname(path) == ".rb" or File.extname(path) == "") 
        @builder['popFile'].popup(nil, nil, event.button, event.time)
    elsif File.extname(path) == ".gemspec"
        @builder['popGemspec'].popup(nil, nil, event.button, event.time)
    elsif File.extname(path) == ".gem"
        @builder['popGemFile'].popup(nil, nil, event.button, event.time)
#    elsif File.directory?(path)
#        @builder['popFolder'].popup(nil, nil, event.button, event.time) 
#    elsif File.directory?(path)
#        @builder

# 'popGladeFile'].popup(nil, nil, event.button, event.time)  
    end
  end

  def self__key_press_event(view, evt)
    return unless evt.keyval == 65535 #delete
    return unless file_name = get_selected_path()
    return unless alert("Delete:   <b>" + File.basename(file_name) + "</b> ?" , 
        :button_yes => "Delete", :button_no=>"Cancel", :parent=>self, :headline => "Delete File?")  
    if File.exist?(file_name) and file_name != Dir.pwd #root!
      delete_me =  @main.tabs.docs.select { |d| d.full_path_file.start_with?(file_name) }
      delete_me.each { |d| @main.tabs.destroy_file_tab(d.full_path_file) }
      delete_selected()
#      @main.tabs.destroy_file_tab(file_name)
      #this is where the nasty error occurs.  If you save_as a file, then delete the old
      # one, the following line crashes the prgogram.
#      @main.file_tree.model.clear
      FileUtils.rm_rf(file_name)
    end

  end


end



