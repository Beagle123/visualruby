
class NewProjectGUI

  include GladeGUI

  def initialize(parent)
    @parent = parent
  end

  def buttonCreate__clicked(*args)
    fn = @builder["entryFolderName"].text
    fn = fn.gsub(/[^\w\.\/\-]/, '_')
    path = File.join($VR_ENV_GLOBAL.projects_home, fn)
    return if fn.length < 2 
    unless File.directory?(path)
      FileUtils.mkpath path
      VR_Tools.copy_skeleton_project(path)
    end
    @parent.proj_path = path
    @builder["window1"].destroy
  end

end
