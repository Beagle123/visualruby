
class VR_File_Tree < VR::FileTreeView 

	include GladeGUI

	def initialize(main, icon_path)
		super(Dir.pwd,icon_path)
		@main = main
		@api = RubygemsAPI.new
		load_glade()
  end

	def self__row_activated(*args)
		return unless rows = selected_rows
		file_name = rows.first[:path]
    if File.extname(file_name) == ".glade" 
      VR_Tools.popen("#{$VR_ENV_GLOBAL.glade_path} #{file_name} ") 	
		else
			@main.tabs.load_tab(file_name) if not File.directory?(file_name)			
		end
	end

	def menuPushGem_clicked
		file_name = get_selected_path() 
		@main.shell.buffer.text = @api.push_gem(file_name)  
	end

	def popInstallGem_clicked()
		file_name = get_selected_path()
#		begin
  		inst = Gem::Installer.new(file_name, :wrappers => true, :ignore_dependencies => true)
  		inst.install().to_s
			txt = "Installed Gem:  " + file_name
			txt += "\nNo check was made for dependencies"
#		rescue 
#			command = "gem install #{file_name} --local 2>&1"
#			txt = VR_Tools.sudo_command(command)
#		end
		@main.shell.buffer.text = txt
	end

	def menuRDoc_clicked
		return unless @main.tabs.try_to_save_all(false)
		fn = get_selected_path() 
		old_dir = Dir.pwd
		FileUtils.cd(fn)
		@main.shell.buffer.text = $VR_ENV.rdoc_command_line + fn + "\n" 
		@main.shell.buffer.text += `#{$VR_ENV.rdoc_command_line} 2>&1`
		VR_Tools.replace_html_in_docs()
		FileUtils.cd(old_dir)
		VR_Tools.popen("#{$VR_ENV_GLOBAL.browser} #{fn}/doc/index.html")
		@main.file_tree.refresh()
	end

	def popBuildGem_clicked
		file_name = get_selected_path()
		@main.tabs.try_to_save_all(false)
		gem_builder = "Invalid .gemspec file:  " + file_name
		begin #try ruby 2.0.0 way first:
			spec = Gem::Specification.load(file_name)
			gem_builder = "Built Gem:\n" + Gem::Package.build(spec)
		rescue #try old way
			spec = Gem::Specification.load(file_name)
			b = Gem::Builder.new(spec)
			b.build()
			gem_builder = b.success()
		end
		@main.shell.buffer.text = gem_builder 
		refresh()           
	end

  def popGlade_clicked
		path = get_selected_path()
		source_code = File.open(path, "r").read
		class_name = VR_Document.get_class_title(source_code).gsub(".rb", "")
#    glade_file = File.dirname(path) + "/glade/" + File.basename(path, ".rb") + ".glade"
    glade_file = File.dirname(path) + "/glade/" + class_name + ".glade" 
    if not File.file?(glade_file)
			path = File.dirname(glade_file)
			FileUtils.makedirs(path) if not File.directory?(path)
			FileUtils.cp File.expand_path(File.dirname(__FILE__)+"/../../skeleton/document/New.glade"), glade_file
      VR_Tools.popen("#{$VR_ENV_GLOBAL.glade_path} #{glade_file}")
      sleep(2) #must do it this way because different thread
      File.delete(glade_file)
    else
      VR_Tools.popen("#{$VR_ENV_GLOBAL.glade_path} #{glade_file}")
    end
  end

  def self__button_release_event(w, event)					# right click
    return unless path = get_selected_path() and event.button == 3
    if File.file?(path) and (File.extname(path) == ".rb" or File.extname(path) == "") 
    		@builder['popFile'].popup(nil, nil, event.button, event.time)
    elsif File.extname(path) == ".gemspec"
    		@builder['popGemspec'].popup(nil, nil, event.button, event.time)
    elsif File.extname(path) == ".gem"
    		@builder['popGemFile'].popup(nil, nil, event.button, event.time)
    elsif File.directory?(path)
    		@builder['popFolder'].popup(nil, nil, event.button, event.time)   
    end
  end

	def self__key_press_event(view, evt)
		return unless evt.keyval == 65535 #delete
		return unless file_name = get_selected_path()
		return unless alert("Delete file:   <b>" + File.basename(file_name) + "</b> ?" , :button_no=>"Cancel", :parent=>self, :headline => "Delete FIle?")  
  	if File.file?(file_name)
			@main.tabs.destroy_file_tab(file_name)
  		File.delete(file_name)
  	elsif File.directory?(file_name) and file_name != Dir.pwd #root!
  		FileUtils.remove_dir(file_name, true)
  	end
  	delete_selected()
	end


end



