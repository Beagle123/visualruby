
class VR_Main 

	include GladeGUI

	attr_accessor :proj_path, :tabs, :shell, :builder, :file_tree	
	
  def initialize(argv)
		@proj_path = argv[0] == "new" ? new_project(argv[1]) : argv[0]
		@proj_path = @proj_path == nil ? Dir.pwd : @proj_path.chomp("/")
		@proj_path = ENV["HOME"] unless File.split(@proj_path).length >= 2 and File.directory?(@proj_path)
	end

	def before_show
#	  splash = Splash.new
#		splash.show(self)
		@file_tree = VR_File_Tree.new(self, File.expand_path(File.dirname(__FILE__) + "/../../img"))
		@builder["scrolledwindowFileTree"].add(@file_tree) 

		#add document notebook		
    @tabs = VR_Tabs.new(self)  
    @builder["vboxTabs"].add(@tabs) 

		#add shell textview
		@shell = VR_TextShell.new(@tabs)
		@builder["scrollShell"].add(@shell) 

		#add local gem tab
		@gem_tree = VR_Local_Gem_Tree.new(self)
		@builder['scrolledLocalGems'].add(@gem_tree) 
		#add remote gem tab
		@remote_gem_tree = VR_Remote_Gem_Tree.new(self)
		@builder["scrolledRemoteGems"].add(@remote_gem_tree)

		menuInstallExamples__activate if not File.directory?(File.join(ENV["HOME"],"","visualruby", "examples", "drag_drop"))

		if Dir.entries(@proj_path).join == "..." #empty
			VR_Tools.copy_recursively(File.dirname(__FILE__) + "/../../skeleton/project", @proj_path)
		end

		if not File.file?(@proj_path + "/" + VR_ENV::SETTINGS_FILE)
			menuInstallExamples__activate if Dir.glob(ENV["HOME"] + File.join( "", "**", VR_ENV::SETTINGS_FILE)).size == 0
			toolOpenFolder_clicked
		else
			load_project(@proj_path)
		end
  end

	def project_valid?(proj_path)
		return false if proj_path.nil?
		if not File.directory?(proj_path.to_s)
			VR::Dialog.message_box("This folder is invalid:\n\n" + proj_path)
			return false
		end
		if ENV["HOME"] == proj_path
			return false
		end
		if Dir.entries(proj_path).join == "..." #empty
			VR_Tools.copy_recursively(File.dirname(__FILE__) + "/../../skeleton/project", proj_path)
			return true
		elsif not File.file?(proj_path + "/" + VR_ENV::SETTINGS_FILE)
			return VR::Dialog.ok_box("No Visual Ruby project file was found in this folder:\n " + proj_path +  "    Do you wan to open it anyway?")
		end #success!
 		return true
	end

	def load_project(proj_path) #assumes valid_project? is true
		FileUtils.cd(proj_path)
		@builder['window1'].title = "VR: " + File.basename(Dir.pwd)
		@builder["labelStatus"].label = Dir.pwd
		$VR_ENV = VR_ENV.load_yaml()
		$VR_ENV_GLOBAL = VR_ENV_GLOBAL.load_yaml()
		@file_tree.root = proj_path
		@file_tree.refresh()
		load_state()
		@shell.buffer.text = ""
	end

	def new_project(proj_path)
		return nil unless proj_path
		path = File.join(Dir.pwd,proj_path)
		FileUtils.mkdir(path) unless File.directory?(path)
		return path
	end

	def toolBack_clicked 
		@tabs.back()
	end

	def toolOpenFolder_clicked
		save_state
		return unless @tabs.try_to_save_all()
		old_path = @proj_path
		ProjectChooserGUI.new(self).show(self) #modal stops execution here, sets @proj_path
		if project_valid?(@proj_path)
 			@tabs.try_to_close_all()
			load_project(@proj_path)
		else
			@proj_path = old_path
		end	
	end

	def notebookTree_changed #file, gem notebook
		case @builder['notebookTree'].page
			when 1 then @gem_tree.refresh() 
			when 2 then @remote_gem_tree.refresh(false) #false = don't force refresh
		end
	end 
	
	def window1_key_press(win, key)
		case x = key.keyval
		 	when 65474 then toolRun_clicked # F5
#			when 115 then toolSave_clicked # Ctrl-S
		end
	end

	def menuCreateLauncher__activate(*a)
		VR_Tools.create_desktop_launcher
	end

	def menuCloseAll__activate(*a)
		@tabs.try_to_close_all() 
	end

	def menuSettings__activate(*a)
		$VR_ENV.show(self)
	end

	def menuGlobalSettings__activate(*a)
		$VR_ENV_GLOBAL.show(self)
		@tabs.update_style_all()
	end

	def menuWWWRubygems__activate(*a)
		VR_Tools.popen("#{$VR_ENV_GLOBAL.browser} https://rubygems.org/users/new")
	end

	def menuSaveAll__activate(*a)
		@tabs.try_to_save_all(false) # don't prompt 
	end

	def menuNew__activate(*a)
    @tabs.load_tab()
	end
	def menuSaveAs__activate(*a)
		@tabs.docs[@tabs.page].save_as()
	end

	def toolRefresh_clicked
		case @builder['notebookTree'].page
			when 0 then @file_tree.refresh()
			when 1 then @gem_tree.refresh()
			when 2 then @remote_gem_tree.refresh()
		end
	end

	def toolSave_clicked()  # saves open tab
		@tabs.docs[@tabs.page].try_to_save(false)
	end	


	#returns false to abort!

	
	def menuNewWindow__activate(*a)
		fn = File.dirname(__FILE__) + "/../../skeleton/document/NewWindow.rb"
		@tabs.load_tab()
		@tabs.set_contents(File.open(fn).read)		
	end

	def menuNewProject__activate(*a)
		save_state
		return unless @tabs.try_to_save_all()
		old_path = @proj_path
		NewProjectGUI.new(self).show(self)
		if project_valid?(@proj_path)
 			@tabs.try_to_close_all()
			load_project(@proj_path)
		else
			@proj_path = old_path
		end	
	end

	def toolBackUp_clicked
   return unless @tabs.try_to_save_all()
		VR_Tools.back_up()
  end


	def toolIndent_clicked
		@tabs.docs[@tabs.page].indent($VR_ENV_GLOBAL.tab_spaces)
  end

	def toolUnIndent_clicked
		@tabs.docs[@tabs.page].unindent($VR_ENV_GLOBAL.tab_spaces)
  end

	def toolComment_clicked
		@tabs.docs[@tabs.page].comment()
  end

	def toolUnComment_clicked
		@tabs.docs[@tabs.page].un_comment()
	end

	def toolRun_clicked
   	run_command($VR_ENV.run_command_line)
  end 		

	def run_command(cmd)
    save_state()
    return unless @tabs.try_to_save_all(false) # false = don't prompt for changes to files
		cur_dir = Dir.pwd
    result = "\n#{cur_dir}$ #{cmd}\n"
    result += `#{cmd} 2>&1`
		FileUtils.cd(cur_dir)
		@shell.hilight_links(result, true)
	end

  def save_state
    return if $VR_ENV == nil
    $VR_ENV.width, $VR_ENV.height = @builder["window1"].size()
    $VR_ENV.panel_pos = @builder["panelMain"].position
    $VR_ENV.open_folders = @file_tree.get_open_folders()
    $VR_ENV.open_files = @tabs.get_open_fn()
    $VR_ENV.current_file = @tabs.docs[@tabs.page].full_path_file
    $VR_ENV.save_yaml()
  end

	def load_state
    @builder["window1"].resize($VR_ENV.width, $VR_ENV.height)
    @builder['panelMain'].set_position($VR_ENV.panel_pos)
    @builder["window1"].visible = true
    @tabs.open_file_names($VR_ENV.open_files)
    @tabs.switch_to($VR_ENV.current_file)
    @file_tree.open_folders($VR_ENV.open_folders)
    @builder["window1"].show_all
	end

	def menuCreateGemspec__activate(*a)
		if file_name = VR_Tools.create_gemspec()
			@tabs.destroy_file_tab(file_name)
  		@tabs.load_tab(file_name)
  		@file_tree.insert(file_name)
		end
	end

	def buttonNext_clicked
		@shell.jump_to()
	end

	def buttonFind_clicked
		str = @builder["entryFind"].text
		str = str.length < 2 ? @tabs.docs[@tabs.page].selected_text() : str
		return if str.length < 2
		text = (@builder["radioOnDisk"].active?) ? @tabs.find_in_all(str) : @tabs.find_in_tabs(str)		
		@shell.hilight_links(text, false)
	end	

	def buttonReplace_clicked
		@tabs.docs[@tabs.page].replace(@builder["entryReplace"].text)
	end

	def entryFind_key_press(me, evt)
		return if evt.keyval != 65293 #enter key
		buttonFind_clicked
	end

	def menuTutorials__activate(*a)
		VR_Tools.popen("#{$VR_ENV_GLOBAL.browser} http://www.visualruby.net")
  end
	
	def menuInstallExamples__activate(*a)
		path = File.join(ENV["HOME"], "", "visualruby", "examples")
		VR_Tools.copy_recursively(File.expand_path(File.join(File.dirname(__FILE__),"","..","..","visualruby_examples")), path) 
		VR::Dialog.message_box("The example projects are installed in:\n#{path}\nIf you want to uninstall them, just delete the folder.\n\nUse the /home/visualruby folder for all your visualruby projects.")			
	end

	#needed so tabs can be saved
  def window1__delete_event(*args)
		save_state
    return true unless @tabs.try_to_save_all()
    return false #ok to close
  end

#called from menu selection to quit
	def destroy_window()    
		@builder["window1"].destroy
	end

end
