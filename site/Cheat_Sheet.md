# @title Cheat Sheet
# Cheat Sheet


## Learn From the Examples
Click on the "Open Project" button, and start on the first example.  This
is the best way to learn.

## Require vrlib
To add a GUI to any class, you must require the vrlib library.  Put this at the top of your file:
```
require "vrlib"
```

## Include GladeGUI
GladeGUI is a module from vrlib.rb.  You must include it in your class to make a GUI:
```
class MyClass
  include GladeGUI
end
```

## Name Files the Same as Class
Visualruby needs to be able to find the .rb file, the class, and the .glade file.
To keep things as organized as possible, you should name your files after the classes they hold:
```
MyClass => MyClass.rb
```
## Locate .glade Files in /glade directory
To open a GUI, visualruby needs to find the .glade file.  It will look in the /glade subdirectory:
```
./MyClass.rb => ./glade/MyClass.glade
```
## Right-click on Files for Menu
In the main screen, you can right-click to see options.  For example, if you
right-click on a .rb file, you will have the option to automatically open
its .glade file in the correct directory.

## Run show_glade() to Show Form
Once you've written your class that includes GladeGUI, just run the show_glade() method:
```
var = MyClass.new()
var.show_glade()
```

## Identify Widgets from their Glade ID
Give glade IDs to your widgets that describe them so you can refer to them in your code.
For example, a button could be:
```
buttonRefresh  # or 
ui_refresh_but
```

## @builder Variable Holds all Widgets
After show_glade() is run, a variable, @builder will be created that holds all widgets:
```
var = @builder[:buttonRefresh]  # => Gtk::Button
```

## Top Window Must have ID, "window1"
When you run show_glade() it will try to open the window with the glade ID, "window1".  Any other name
will not work.

## Event Handler Naming Convention
When an event occurs, like a button click, your program will respond by running
a method according to a naming convention.  So, if a widget
with ID, "buttonRefresh" is "clicked", it would run this method:
```
def buttonRefresh__clicked(*args) 
  # refresh code here.
end
```
Note:  There are TWO UNDERSCORES between the glade ID and the signal name.
You don't need to define event handlers in glade.







