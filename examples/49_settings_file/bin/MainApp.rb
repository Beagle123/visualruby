
class MainApp 
 
  include GladeGUI
  
  # make $ENV global object available everywhere
  def before_show()
    $ENV = VR::load_yaml(SavableSettings, "settings.yaml")
    @builder[:window1].resize $ENV.width, $ENV.height
    refresh()
  end  

  def refresh()
    @builder[:text].text = $ENV.text
    @builder[:window1].title = $ENV.title
  end  

  def buttonEdit__clicked(*a)
    $ENV.show_glade(self)
    refresh()
  end

  # delete_event signal occurs before the window actually closes
  # It gives us time to save the height and width of the widow before 
  #closing it.  Returns: true = don't close window, false = close window.
  def window1__delete_event(*)
    $ENV.width, $ENV.height = @builder[:window1].size()
    VR::save_yaml($ENV)
    return false #ok to close
  end

  def buttonCancel__clicked(*a)
    window1__delete_event
    @builder[:window1].destroy
  end

end

