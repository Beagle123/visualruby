
class VR_ENV

	include GladeGUI

	SETTINGS_FILE = ".vr_settings.yaml"

	attr_accessor :width, :height, :panel_pos, :rdoc_command_line
	attr_accessor :run_command_line, :open_files, :open_folders, :current_file
  attr_accessor :notebook_panel_position


	def initialize()
		defaults
		save_yaml()		
	end

	#to add setting, just add to list
	def defaults
		@width ||= 800
		@height ||= 600
		@panel_pos ||= 360
		@notebook_panel_position ||= 400
		@run_command_line ||= "ruby main.rb"
		@open_files ||= []
		@open_folders ||= []
		@current_file ||= ""
		@rdoc_command_line ||= "rdoc -x README"
	end 


	#todo validate
	def buttonSave_clicked
		get_glade_variables
		save_yaml()
		@builder["window1"].destroy
	end


	def self.load_yaml()
		if File.file?(SETTINGS_FILE) 
		 	me = YAML.load(File.open(SETTINGS_FILE).read)
			me.defaults
			return me 
		else
	  	VR_ENV.new()
		end
	end

	def save_yaml()
		data = YAML.dump(self)
		VR::msg("Saving data:" + data)
		VR::msg( "Saving: \n\n" + Dir.pwd + "/" + SETTINGS_FILE)
		File.open(Dir.pwd + "/" + SETTINGS_FILE, "w") {|f| f.puts(data)}
		return self
	end

	def buttonCancel__clicked(*args)
		@builder["window1"].destroy
	end		

end
