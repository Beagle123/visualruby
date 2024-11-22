
This example shows how a instance variable named @builder is 
automatically created when the show_glade method is called.
When show_glade() is called, the GladeGUI module will run this code:

  @builder = Gtk::Builder.new(file: "glade/BuilderDemo.glade")

which loads the glade file into the @builder variable.  This is done
behind the scenes in Glade GUI, so the @builder variable will magically
apper in your script.

The @builder variable holds references to all the widgets (and windows etc).
You can access any widget using its glade ID:

  widget = @builder["ui_widget_btn"]

You can get and set properties:

  my_button = @builder["ui_widget_btn"]     # retreives reference to button
  puts my_button.label                      # using GtkLabel's "label" property.
  my_button.label = "Click Me"              # Changes button's text to "Click Me"


However, the @builder variable isn't created until show_glade() is called
so it isn't useable in the initialize() method.  But you can use it in a method,
before_show().  This is a method that's automatically called before
the window is shown.

SUMMARY:
1) The @builder variable is created when you call show_glade()
2) Every item in the glade form can be retreived with its glade ID
3) @builder is an instance variable so visible to subclasses etc.



  
