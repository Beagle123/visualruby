
class ProjectTree < VR::FileTreeView  #(change name)
 
	attr_accessor :ftv

	include GladeGUI

	def initialize()
		path = $VR_ENV_GLOBAL.projects_home
		icon_path = File.expand_path(File.join(File.path(__FILE__), "..", "..", "..", "img"))
		super(path, icon_path)
		@test_block = proc { |folder| has_settings_file?(folder) } 
		open_folders($VR_ENV_GLOBAL.projects_home_open_folders) 
	end

	def has_settings_file?(path)
		Find.find(path) do |file|
  		if File.basename(file) == VR_ENV::SETTINGS_FILE
				return true
			end
		end
		return false
	end

end
