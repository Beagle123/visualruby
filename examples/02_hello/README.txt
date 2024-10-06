
This "hello world" script is simple, but there are some important lessons
to be learned from it.

So where is it creating this window from?

There is a file named HelloGUI.glade in the glade folder.  If you double click on it,
the Glade Interface Designer, should start and load the MyClass.glade file.

If you get that command to work on the command line, visualruby will work too.
You can find the command in menu "Tools>Global Settings"  See the installation
instructions for Glade and Visualruby for help.

The name and location of this file is not an accident.  You must keep your .glade files in a
folder named "glade" that resides in the same folder as your script.  That's where visualruby
looks for it.  And the glade file shares the same name as the class file.  So it maps like this:

HelloGUI.rb  ==>  HelloGUI.glade

If you doubleclick on MyClass.glade, the file will open.
In the glade editor, You will find a button with the name, "ui_hello_btn"  
This ID follows a naming convention:

ui_hello_btn

ui = user interface
hello = identifier
btn = a button

This naming convention isn't required, but it helps distinguish a variable that
refers to a widget from one of your variables.

So how does it make the window?

In main.rb, notice that it includes the line:

include GladeGUI

This is where the magic happens.  You need to include this in any files using a glade GUI. This line:

HelloGUI.new().show_glade()

Creates and instance of HelloGUI and runs the #show_glade() method, showing the form.  
The #show_glade method is in GladeGUI.   So when you include GladeGUI in a HelloGUI.rb,
you can call the #show_glade method to show the GUI on the screen.

The #show_glade method will call a more hidden method, #load_glade:

  def load_glade()    
    file_name = "glade/HelloGUI.glade"
    @builder = Gtk::Builder.new(file: file_name)
    @builder.connect_signals{ |handle| method(handle) }
  end

So this looks for the file, "glade/HelloGUI.glade" and loads all the controls into a variable named @builder.
This @builder variable is the gateway access to all the controls in the window.  (see other tutorials)  
Also, it connects the event handlers to all the controls so you
can have your program respond to events like clicks:

From MyClass.rb:

  def ui_hello_btn__clicked(*args)
    @builder["ui_hello_btn"].label = "Goodbye World" 
  end

(more on this in later examples)

So this is the method that is called when you click the hello button with its glade ID: ui_hello_btn.
The name of this method is definately not an accident either.  It follows a naming convention:

glade_id__event (two underscores!)

So when you click the button, It will see that the glade ID of the button is ui_hello_btn, and 
the event that occured is named "clicked" so it runs the method #ui_hello_btn__clicked.

The @builder object is a hash of controls, so you retreive a control using its glade ID. 
The code retreives the button object which has a property called "label" which is text displayed
on the button.  When it sets the label to "Goodbye World" the screen updates.

There are far too many methods and properties for every type of control.  Consult the gtk docs
to learn the names of the events and properties for all the controls.  Also, look in the
glade designer controls.  It shows the names of many properties and signals (events) like
"label" and "clicked"


