
class OpenProject

  include GladeGUI

  def initialize(parent)
    @parent = parent
    @projects_home = $VR_ENV_GLOBAL.projects_home
  end

  def before_show
    @ftv = ProjectTree.new()
    @ftv.set_show_expanders(false)
    @builder["view"].add(@ftv)
    @ftv.visible = true
  end

  def ftv__cursor_changed(*a)
    @ftv.expand_or_collapse_folder() 
  end

  def ftv__row_activated(_self, path, col)
    return unless row = @ftv.selected_rows.first
    if @parent.project_valid?(row[:path])
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
      test_file = File.join(row[:path], VR_ENV::SETTINGS_FILE)
      if File.exists?(test_file) 
         @parent.proj_path = row[:path]
        buttonCancel__clicked
      else
#        alert("This is not a visualruby project.  It's a folder that holds visualruby projects.", :parent=>self, :width=>400)
        @ftv.expand_or_collapse_folder()
      end
  end

  def buttonNew__clicked(*a)
    old_proj_path = @parent.proj_path
    NewProjectGUI.new(@parent).show_glade(self)
    @builder[:window1].destroy if @parent.proj_path != old_proj_path  #new path created!
  end


  def buttonCancel__clicked(*a) #save state
    $VR_ENV_GLOBAL.projects_home_open_folders = @ftv.get_open_folders()
    VR::save_yaml($VR_ENV_GLOBAL)
    @builder["window1"].destroy    
  end

end
