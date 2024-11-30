
class OpenProject

  include GladeGUI

  def initialize(parent)
    @parent = parent
    @projects_home = $VR_ENV_GLOBAL.projects_home
  end

  def before_show
    @ftv = ProjectTree.new()
    @ftv.show
    @ftv.set_show_expanders(false)
    @builder["view"].add_child(@ftv)
  end

  def ftv__cursor_changed(*a)
    @ftv.expand_or_collapse_folder() 
  end

  def ftv__row_activated(_self, path, col)
    return unless row = @ftv.selected_rows.first 
    if VR_Tools.vr_project?(row[:path])
      buttonOpen__clicked
    else
      @ftv.expand_or_collapse_folder()
    end
  end

  def buttonChange__clicked(*a)
    $VR_ENV_GLOBAL.show_glade(self)
    @projects_home = $VR_ENV_GLOBAL.projects_home
    @ftv.refresh(:root => @projects_home)
    @builder[:projects_home].label = @projects_home
  end

  def buttonDelete__clicked(*a)
    return unless row = @ftv.selected_rows.first
    return if row[:path] == Dir.pwd  #can't delete current project
    if alert("Do you really want to delete  \n<b>" + row[:path] + " </b>?", 
        parent: self, headline: "Warning!", button_yes: "Delete", button_no: "Cancel", width: 400)
      FileUtils.remove_dir(row[:path], true)
      @ftv.refresh()
    end
  end

  def buttonOpen__clicked(*a)
      return unless row = @ftv.selected_rows.first
      if VR_Tools.vr_project?( row[:path] ) 
        @parent.load_project( row[:path])
#         @parent.proj_path = row[:path]
        buttonCancel__clicked
      else
        @ftv.expand_or_collapse_folder()
      end
  end

  def buttonNewWindow__clicked(*a)
    return unless row = @ftv.selected_rows.first
    if VR_Tools.vr_project?(row[:path]) 
      Open3.popen3("vr #{row[:path]}")
      buttonCancel__clicked
    else
      @ftv.expand_or_collapse_folder()
    end
  end

  def buttonNew__clicked(*a)
    old_proj_path = @parent.proj_path
    NewProjectGUI.new(@parent).show_glade(self)
    buttonCancel__clicked if @parent.proj_path != old_proj_path  #new path created!
  end


  def buttonCancel__clicked(*a)
    $VR_ENV_GLOBAL.projects_home_open_folders = @ftv.get_open_folders()
    VR::save_yaml($VR_ENV_GLOBAL)
    @builder["window1"].close  
  end

end
