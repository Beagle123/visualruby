
class ProjectTree < VR::FileTreeView  #(change name)
 
	attr_accessor :ftv

	include GladeGUI

	def initialize()
		path = File.join(ENV["HOME"], "visualruby")
		super(path,  "/home/eric/vrp/vr3/img")
		@test_block = proc { |folder| has_settings_file?(folder) }
	end

  def self__row_activated(_self, path, col)
  		row = vr_row(get_iter(path))
			if File.exists?(File.join(row[:path], ".vr_settings.yaml")) #test if its a vr project.
 				alert "You selected:		\n\n" + row[:file_name]
			else
				expand_or_collapse_folder()
			end
	end

	def has_settings_file?(path)
		Find.find(path) do |file|
  		if File.basename(file) == ".vr_settings.yaml"
				return true
			end
		end
		return false
	end

end
