
class VR_ENV

	include GladeGUI

	SETTINGS_FILE = ".vr_settings.yaml"
	SETTINGS_FILE_VERSION = 1

	attr_accessor :width, :height, :panel_pos, :rdoc_command_line, :settings_file_version
	attr_accessor :run_command_line, :open_files, :open_folders, :current_file


	def initialize()
		@settings_file_version = SETTINGS_FILE_VERSION
		@width = 800
		@height = 600
		@panel_pos = 360
		@run_command_line = "ruby main.rb"
		@open_files = []
		@open_folders = []
		@current_file = ""
		@rdoc_command_line = "rdoc -x README"
		save_yaml()		
	end

	#todo validate
	def buttonSave_clicked
		get_glade_variables
		save_yaml()
		@builder["window1"].destroy
	end


	def self.load_yaml()
		if File.file?(SETTINGS_FILE) 
		 	me = YAML::load(File.open(SETTINGS_FILE).read)
			return VR_ENV.new() if me.settings_file_version.nil?
			return VR_ENV.new() if me.settings_file_version < SETTINGS_FILE_VERSION
			return me 
		else
	  	VR_ENV.new()
		end
	end

	def save_yaml()
		data = YAML.dump(self)
		File.open(Dir.pwd + "/" + SETTINGS_FILE, "w") {|f| f.puts(data)}
		return self
	end

	def buttonCancel__clicked(*args)
		@builder["window1"].destroy
	end		

end
