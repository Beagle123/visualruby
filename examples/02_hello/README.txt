
This "hello world" script is simple, but there are some important lessons
to be learned from it.

As before, the HelloGUI.rb class has a corresponding glade file, HelloGUI.glade, to add a GUI.
It maps like this:

HelloGUI.rb  ==>  glade/HelloGUI.glade

If you doubleclick on HelloGUI.glade, the file will open, and you can see
the button with ID: "ui_hello_btn"  

This ID follows a naming convention:

  ui = user interface
  hello = identifier
  btn = a button

This naming convention isn't required, but it helps distinguish a variable that
refers to a widget from one of your variables.

The main program creates an instance of the HelloGUI class and shows it:

  HelloGUI.new().show_glade()

The following method uses this ID, such that it runs when the button is clicked:

From HelloGUI.rb:

  def ui_hello_btn__clicked(*args)
    alert("Hello World") 
  end


The name of this method is definately not an accident.  It follows a naming convention:

<GladeID>__<event>      # two underscores between ID and event!

So the method, ui_hello_btn__clicked(*args) runs when the button with glade ID "ui_hello_btn"
encounters a "clicked" event.  To make this work, you only need to create a unique glade ID and
name your method correctly.  It will call the method based on its name.


SUMMARY:
1) Give the widgets on the form unique glade IDs, then refer to them by their ID.
2) Store your glade files in the subdirectory /glade.  Mapping:  MyClass.rb => glade/MyClass.glade
3) Visualruby will call event handlers by the naming convention: <GladeID>__<event> (see next examples)



