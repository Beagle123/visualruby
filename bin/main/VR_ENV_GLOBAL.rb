
class VR_ENV_GLOBAL
		
	GLOBAL_SETTINGS_FILE = File.join(ENV["HOME"], "visualruby", ".vr_global_settings")
	SETTINGS_FILE_VERSION = 1

	include GladeGUI
	
	attr_accessor :browser, :tab_spaces, :glade_path
	attr_accessor :font_name, :settings_file_version

	def initialize
		@settings_file_version = SETTINGS_FILE_VERSION
		@browser = "firefox"
		@tab_spaces = 2
		@font_name = "Monospace 10"
		@glade_path = "glade"
		save_yaml
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

	def save_yaml
		data = YAML.dump(self)
		File.open(GLOBAL_SETTINGS_FILE, "w") {|f| f.puts(data)}
	end

	def self.load_yaml()
		if File.file?(GLOBAL_SETTINGS_FILE) 
		 	me = YAML::load(File.open(GLOBAL_SETTINGS_FILE).read)
			return VR_ENV_GLOBAL.new() if me.settings_file_version.nil?
			return VR_ENV_GLOBAL.new() if me.settings_file_version < SETTINGS_FILE_VERSION
			return me 
		else
	  	VR_ENV_GLOBAL.new()
		end
	end

	def buttonTryGlade__clicked(*argv)
		VR_Tools.popen(@glade_path)
	end

	def buttonTryBrowser__clicked(*argv)
		VR_Tools.popen(@browser)
	end

end
