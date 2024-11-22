
class Menus 
 
  include GladeGUI

  def ui_open_menu__activate(*args)
    alert("Opening File...")
  end

  def ui_save_menu__activate(*args)
    alert("Saving File...")
  end

  def ui_quit_menu__activate(*args)
    @builder["window1"].close
  end

  def ui_about_menu__activate(*args)
    alert("Version 16.7.31", headline: "Menu Program")
  end

  def ui_zoom_tool__clicked(*args)
    alert("Zooming In...")
  end

  def ui_home_tool__clicked(*args)
    alert("Going Home...")
  end

end

