
class NewProjectGUI

  include GladeGUI

  def initialize(parent)
    @parent = parent
    @projects_home = $VR_ENV_GLOBAL.projects_home + "/" # sets in glade
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
    # creates .vr_settings.yaml
    VR::load_yaml(VR_ENV, path + "/" + VR_ENV::SETTINGS_FILE)
    @parent.load_project(path)
    @builder["window1"].close
  end

end
