
This example shows a shortcut to assigning initial properties
to widgets in your glade form.  This method can be used in the
initialize() method because it only assigns values to variables
that are later loaded into widgets when show_glade() is called.

So this works:

  def initialize()
    @ui_splash_img = "src/splash.png"
  end

In ititialize() @ui_splash_img is a String.  But, when show_glade()
is called,  it will be loaded into the glade form. 
The glade form contains an ID named ui_splash_img  (a Gtk::Image)
This is how GladeGUI loads the string into the Gtk::Image:

  GladeGUI:

  if @builder["ui_splash_img"].is_a Gtk::Image
    @builder["ui_splash_image"].file = @ui_splash_img
  end

So its finding where a variable name matches a glade ID and populating
the widget with the appropriate data.

There is a method named set_glade_variables() in GladeGUI that does
this translating.  And there is a another method named get_glade_variables()
that retreives the widget variables back into the instance variables.
See the example named "get_glade_variables" for more.  

Note: you must add an "adjustment" object to the spinbutton in glade
to make it work.


