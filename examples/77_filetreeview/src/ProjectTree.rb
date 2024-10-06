#  This demonstrates the VR::FileTreeView class.  You can configure it using a glob and a
#  validation block.  It will only include the files and folders designated in the glob 
#  and that have the vaildation block return true.
#  
#  It does this:
#  
#  files = Dir.glob(folder_path, glob)
#  files = files.select &@validate_block
#  
#  It takes the root of the file tree as the first argument, and a path to the icon files
#  to display next to the files and folders.  THe icons are named according to the extension.
#  For example, 'rb.png' will display next to files with a '.rb' extension.


class ProjectTree < VR::FileTreeView 
 
  attr_accessor :ftv

  include GladeGUI

  def initialize()
    root_path = File.join(ENV["HOME"], "visualruby")
    icon_path = File.join(File.dirname(__FILE__), "/../img")
    super(root_path, icon_path, "*" , proc { |folder| has_settings_file?(folder) })
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
