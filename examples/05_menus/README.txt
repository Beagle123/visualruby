
Menus

You can easily make menus and toolbars in glade without any lines of code.  You
just insert a menu into your form using glade, and give each menu item a unique name, then
create a method to run when the user selects the menu item.

You can see the menus for this example program by double-clicking the Menus.glade file.  Then
right-click on the MenuBar in the tree and select "Edit." 
You'll see that theres a menu and a toolbar with the following menu items:

  ui_open_menu
  ui_save_menu
  ui_quit_menu
  
  ui_zoom_tool
  ui_home_tool
  etc.
 

When you select a menu item, an event named "activate" is fired, so you can write
a method to handle this event:

  def ui_open_menu__activate(*args)
    alert("Open clicked...")
  end 

Likewise, the toolbar items are buttons so they have a "clicked" event:

  def ui_zoom_tool__clicked(*args)
    alert("Zooming in...")
  end

You can build the whole thing in glade, then just write event handlers with the
naming convention:

<GladeID>__<event>    # two underscores!

