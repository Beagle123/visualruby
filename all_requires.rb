  require "rubygems"
  require "yaml" #needed
  require "net/http" #needed
  require "net/https" #needed
  require "fileutils" #needed
  require "rubygems/installer"
  require "rubygems/uninstaller"
  require "rubygems/package"
  require "rubygems/specification"
  
  require_relative 'lib/vrlib'
  
  require_relative "src/version"

  require_relative 'src/editor/VR_TextViewCommon'
  require_relative "src/editor/VR_TextShell"
  require_relative "src/editor/VR_TabSearch"
  require_relative "src/editor/VR_Tabs" 
  require_relative "src/editor/VR_Document"


  require_relative "src/main/GemTree"
  require_relative "src/main/NewProjectGUI"
  require_relative "src/main/OpenProject"
  require_relative "src/main/ProjectTree"
  require_relative "src/main/RubygemsAPI"
  require_relative "src/main/VR_ENV_GLOBAL"
  require_relative "src/main/VR_ENV"
  require_relative "src/main/VR_File_Tree"
  require_relative "src/main/VR_Local_Gem_Tree"
  require_relative "src/main/VR_Main"
  require_relative "src/main/VR_Remote_Gem_Tree"
  require_relative "src/main/VR_Tools"

  require_relative "lib/TestWindow"
