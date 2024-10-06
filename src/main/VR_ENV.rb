class VR_ENV 

  include GladeGUI

  SETTINGS_FILE = ".vr_settings.yaml"

  attr_accessor :width, :height, :panel_pos, :rdoc_command_line
  attr_accessor :run_command_line, :open_files, :open_folders, :current_file
  attr_accessor :notebook_panel_position, :current_line

  #to add setting, just add to list
  def defaults
    @width ||= 800
    @height ||= 600
    @panel_pos ||= 360
    @notebook_panel_position ||= 300
    @run_command_line ||= "ruby main.rb"
    @open_files ||= []
    @open_folders ||= []
    @current_file ||= ""
    @current_line ||= 1
    @rdoc_command_line ||= "rdoc -x README"
  end 


  #todo validate
  def buttonSave_clicked
    get_glade_variables
    VR::save_yaml(self)
    @builder["window1"].destroy
  end

  def buttonCancel__clicked(*args)
    @builder["window1"].destroy
  end    

end


