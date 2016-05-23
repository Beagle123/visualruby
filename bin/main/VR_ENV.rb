class VR_ENV < VR::SavableClass

	include GladeGUI

	SETTINGS_FILE = ".vr_settings.yaml"

	attr_accessor :width, :height, :panel_pos, :rdoc_command_line
	attr_accessor :run_command_line, :open_files, :open_folders, :current_file
  attr_accessor :notebook_panel_position, :filename

	#to add setting, just add to list
	def defaults
		@filename ||= SETTINGS_FILE  # ".vr_settings.yaml"
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

	def buttonCancel__clicked(*args)
		@builder["window1"].destroy
	end		

end


#class VR_ENV
#
#	include GladeGUI
#
#	SETTINGS_FILE = ".vr_settings.yaml"
#
#	attr_accessor :width, :height, :panel_pos, :rdoc_command_line
#	attr_accessor :run_command_line, :open_files, :open_folders, :current_file
#  attr_accessor :notebook_panel_position, :filename
#
#
#	def initialize(filename = nil)
#		@filename = filename ? filename : self.class.name + ".yaml"
#		defaults
#		save_yaml()		
#	end
#
#	#to add setting, just add to list
#	def defaults
#		@width ||= 800
#		@height ||= 600
#		@panel_pos ||= 360
#		@notebook_panel_position ||= 400
#		@run_command_line ||= "ruby main.rb"
#		@open_files ||= []
#		@open_folders ||= []
#		@current_file ||= ""
#		@rdoc_command_line ||= "rdoc -x README"
#	end 
#
#
#	#todo validate
#	def buttonSave_clicked
#		get_glade_variables
#		save_yaml()
#		@builder["window1"].destroy
#	end
#
#
#	def self.load_yaml(filename)
#		if File.file?(filename) 
#		 	me = YAML.load(File.open(filename).read)
#			me.filename = filename
#			me.defaults
#			return me 
#		else
#	  	VR_ENV.new()
#		end
#	end
#
#	def save_yaml(new_filename = nil)
#		@filename = new_filename if new_filename
#		data = YAML.dump(self)
#		File.open(@filename, "w") {|f| f.puts(data)}
#		return
#	end
#
#	def buttonCancel__clicked(*args)
#		@builder["window1"].destroy
#	end		
#
#end
#
