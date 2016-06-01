
class VR_ENV_GLOBAL
		
	GLOBAL_SETTINGS_FILE = File.join(ENV["HOME"], "visualruby", ".global_settings.yaml")

	include GladeGUI
	
	attr_accessor :browser, :tab_spaces, :glade_path, :default_project, :projects_home_open_folders
	attr_accessor :font_name, :settings_file_version, :projects_home
 
	def defaults()
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
		if valid?
			get_glade_variables
			@tab_spaces = @builder['tab_spaces'].text.to_i
			VR::save_yaml(self)
			@builder["window1"].destroy
		end
	end

	def valid?  # must validate form, not variables
		tab_spaces = @builder['tab_spaces'].text.to_i
		if tab_spaces < 0 or tab_spaces > 9
			alert("Tab spaces must be between 1 and 9", :parent=>self)
			return false
		elsif not File.directory?(@builder[:projects_home].text)
			alert("Projects home folder is not valid.", :parent=>self)
			return false			
		elsif not File.exists?(File.join(@builder[:default_project].text,VR_ENV::SETTINGS_FILE))
			alert("Default project is not valid.", :parent=>self)
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
