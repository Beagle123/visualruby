
This "hello world" script is simple, but there are some important lessons
to be learned from it.

First try clicking the "Run" button, and the main.rb script will run, causing 
a window to appear.

The "Run" button is simply running the command "ruby main.rb" If you click on:
Tools>Project Settings
you can edit this command to run any script you create.

So where is it creating this window from?
There is a file named MyClass.glade in the glade folder.  If you double click on it,
the Glade Interface Designer, should start and load the MyClass.glade file.

If this malfunctions, you need to install glade and make sure the command is working
on the command line.  You should be able to enter "glade" on the command line to run it.
Visualruby is simply running the command:

glade glade/MyClass.glade

If you get that command to work on the command line, visualruby will work too.
You can find the command in menu "Tools>Global Settings"  See the installation
instructions for Glade and Visualruby for help.

The and location of this file is not an accident.  You must keep your .glade files in a
folder named "glade" that resides in the same folder as your script.  That's where visualruby
looks for it.

In the glade editor, You will find a button with the ID "ui_hello_btn"  
This ID follows a naming convention of starting with "ui_" to denote
that we're referring to an object on the glade form.  It ends with "_btn"
to give the clue that this is a button.  Not following this naming convention
won't cause errors, but it makes it so you won't mistake a glade ID for one of your variables.

So how does it make the window?
In main.rb, notice that it includes the line:

include GladeGUI

This is where the magic happens.  You need to include this in any files using a glade GUI. This line:

MyClass.new().show_glade()

Creates and instance of MyClass and runs the #show_glade() method to show the form.  
The #show_glade method is in GladeGUI and therefore also in MyClass.
The #show_glade method will call a more hidden method, #load_glade:


   def load_glade() 
    caller__FILE__ = my_class_file_path()    
    file_name = File.join(File.split(caller__FILE__)[0] , "glade", class_name(self) + ".glade")
    @builder = Gtk::Builder.new(file: file_name)
    @builder.connect_signals{ |handle| method(handle) }
  end

So this looks for the file, "glade/MyClass" and loads all the controls into a variable named @builder.
This @builder variable is visible to MyClass and it is the gateway access to all the controls in
the window.  (see other tutorials)  Also, it connects the event handlers to all the controls so you
can have your program respond to events like clicks:

From MyClass.rb:

  def ui_hello_btn__clicked(*args)
    @builder["ui_hello_btn"].label = "Goodbye World" 
  end

So this is the method that is called when you click the hello button with its glade ID: ui_hello_btn.
The name of this method is definately not an accident either.  It follows a naming convention:

glade_id__event (two underscores!)

So when you click the button, It will see that the glade ID of the button is ui_hello_btn, and 
the event that occured is named "clicked" so it runs the method #ui_hello_btn__clicked.

The @builder object is a hash of controls, so you retreive a control using its glade ID. 
The code retreives the button object which has a property called "label" which is text displayed
on the button.  When it sets the label to "Goodbye World" the screen updates.

There are far too many methods and properties for every type of control.  Consult the gtk docs
to learn the names of the events and properties for all the controls.



