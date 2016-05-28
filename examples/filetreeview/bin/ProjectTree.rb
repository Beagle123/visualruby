
class ProjectTree < VR::FileTreeView  #(change name)
 
	attr_accessor :ftv

	include GladeGUI

	def initialize()
		path = File.join(ENV["HOME"], "visualruby")
		super(path,  "/home/eric/vrp/vr3/img")
		@test_block = proc { |folder| has_settings_file?(folder) }
		fill_folder()
		expand_row(@root_iter.path, false) # Gtk
	end


  def self__row_activated(_self, path, col)
  		iter = vr_row(get_iter(path))
 			alert "You selected:		\n\n" + iter[:file_name]
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
