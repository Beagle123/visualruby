
class VR_ENV_GLOBAL < VR::SavableClass
		
	GLOBAL_SETTINGS_FILE = File.join(ENV["HOME"], "visualruby", ".global_settings.yaml")

	include GladeGUI
	
	attr_accessor :browser, :tab_spaces, :glade_path, :default_project, :projects_home_open_folders
	attr_accessor :font_name, :settings_file_version, :filename, :projects_home
 
	def defaults()
		@filename ||= GLOBAL_SETTINGS_FILE
		@browser ||= "firefox"
		@tab_spaces ||= 2
		@font_name ||= "Monospace 10"
		@glade_path ||= "glade"
		@projects_home ||= File.join(ENV["HOME"], "visualruby")
		@projects_home_open_folders ||= [@projects_home]
		@default_project ||= File.join(ENV["HOME"], "visualruby", "examples", "treeview")
	end

	def before_show
		@builder["font_name"].show_size = true
	end

	def buttonSave_clicked
		get_glade_variables
		if valid?
			save_yaml()
			@builder["window1"].destroy
		end
	end

	def valid?
		@tab_spaces = @builder['tab_spaces'].text.to_i
		if @tab_spaces < 0 or @tab_spaces > 9
			alert("Tab spaces must be between 1 and 9", :parent=>self)
			return false
		elsif not File.directory?(projects_home)
			alert("Projects home folder is not valid.", :parent=>self)
			return false			
		elsif not File.exists?(File.join(default_project,VR_ENV::SETTINGS_FILE))
			alert("Default Project is not valid.", :parent=>self)
			return false			
		end
		return true
	end

	def buttonCancel__clicked(*args)
		@builder["window1"].destroy
	end		

	def buttonTryGlade__clicked(*argv)
		VR_Tools.popen(@glade_path)
	end

	def buttonTryBrowser__clicked(*argv)
		VR_Tools.popen(@browser)
	end

	def buttonCurrent__clicked(*argv)
		@builder["default_project"].text = Dir.pwd
	end

end
