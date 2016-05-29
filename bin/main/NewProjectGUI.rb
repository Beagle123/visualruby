
class NewProjectGUI

	include GladeGUI

	attr_accessor :my_var

	def initialize(parent)
		@parent = parent
		@projects_home = $VR_ENV_GLOBAL.projects_home + "/"
	end

	def buttonCreate__clicked(*args)
		fn = @builder["entryFolderName"].text
		fn = fn.gsub(/[^\w\.\/]/, '_')
		path = File.join($VR_ENV_GLOBAL.projects_home + "/" + fn)
		if File.directory?(path)
			alert "The folder <b>" + path + "</b> is already ok disk.  You can open it using the <b>Open Project</b> button.",
				:headline=> "Project Already Exists", :parent => self, :width => 500
		else
			FileUtils.mkpath path
			VR_Tools.copy_skeleton_project(path)
			@parent.proj_path = path
			@builder["window1"].destroy
		end
	end

	def buttonCancel__clicked(*args)
		@my_var = "Hello"
#		@builder["window1"].destroy
	end

end
