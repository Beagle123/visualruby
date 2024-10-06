
This example shows how a instance variable named @builder is created
autimatically when a window is shown by the show_glade() method.
When show_glade() is called, the GladeGUI module will run this code:

  @builder = Gtk::Builder.new(file: "glade/BuilderDemo.glade")

which loads the glade file into the @builder variable.  This is done
behind the scenes in Glade GUI, so the @builder variable will magically
apper in your script.

You can retreive the widgets (and windows etc) from the @builder variable
using the ID from glade:

  widget = @builder["ui_widget_btn"]

You can get and set properties:

  lab = @builder["ui_widget_btn.label"].label
  @builder["ui_widget_btn"].label = "Click Me"

However, the @builder variable isnt created until show_glade() is called
so it isn't useable in the initialize() method.  But you can use it in a method,
before_show().  This is a method that's automatically called before
the window is shown.

Takeaways:
1) The @builder variable is created when you call show_glade()
2) Every item in the glade form can be retreived with its glade ID
3) @builder is an instance variable so visible to subclasses etc.



  
