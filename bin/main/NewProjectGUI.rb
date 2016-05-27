
class NewProjectGUI

	include GladeGUI

	def initialize(parent)
		@parent = parent
		@parent.proj_path = nil
		@labelHomePath = File.join(ENV["HOME"], "visualruby" + "/")
	end

	def buttonCreate__clicked(*args)
		fn = @builder["entryFolderName"].text
		fn = fn.gsub(/[^\w\.]/, '_')
		path = File.expand_path(File.join("~", "visualruby", fn))
		if File.directory?(path)
			alert "That folder is already present.  You can open it using the <b>Open Project</b> button.", :headline=> "Project Already Exists", :parent => self, :width => 320
		else
			Dir.mkdir path
			@parent.proj_path = path
			@builder["window1"].destroy
		end
	end

	def buttonCancel__clicked(*args)
		@builder["window1"].destroy
	end

end
