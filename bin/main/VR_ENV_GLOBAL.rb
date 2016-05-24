
class VR_ENV_GLOBAL < VR::SavableClass
		
	GLOBAL_SETTINGS_FILE = File.join(ENV["HOME"], "visualruby", "global_settings.yaml")

	include GladeGUI
	
	attr_accessor :browser, :tab_spaces, :glade_path, :default_project
	attr_accessor :font_name, :settings_file_version, :filename

	def defaults()
		@filename ||= GLOBAL_SETTINGS_FILE
		@browser ||= "firefox"
		@tab_spaces ||= 2
		@font_name ||= "Monospace 10"
		@glade_path ||= "glade"
		@default_project ||= ""
	end

	def before_show
		@builder["font_name"].show_size = true
	end

	#todo validate
	def buttonSave_clicked
		get_glade_variables
		spaces = @builder['tab_spaces'].text.to_i
		@tab_spaces = spaces if spaces > 0 and spaces < 9
		save_yaml()
		@builder["window1"].destroy
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
