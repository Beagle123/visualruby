
To start, click the "Run" button, and the program will appear.

Clicking the run button, simply runs this command: 

ruby phantom.rb

You can see and edit the "Run" command in menu:  Tools > Project Settings 

Try right-clicking on the files on the left to see options.

Next, try editing a glade file by clicking on the glade folder,
and double clicking on Phantom.glade.  If this does't work,
you need to install the Glade Interface Designer.  To use
the Glade editor, you need to make the command, "glade" execute
from the command prompt.



Phantom Project:

Even though this program has virtually no lines of
code, its still creating a robust program.

The most important lines are:

require 'vrlib'
 
and

include GladeGUI

The vrlib.rb library is located in the visualruby gem, and it contains
all the important functions of visualruby.  Every program should begin with the line:

require "vrlib"

The GladeGUI module is in vrlib.rb, and it contains the vital methods
to transform the glade forms into ruby programs.

One important method in GladeGUI is the #show_glade method.  It reads the
glade file, and shows it on the screen. 

So this line of code:

Phantom.new.show_glade()

Creates an instance of Phantom, then reads the file, Phantom.glade, and displays
it on screen.  It will look for a window object in the glade file named "window1".
Any other name won't work.

Just remember to always require vrlib, and include GladeGUI and visualruby will
do its magic.  

Summary:
1) Visualruby will automatically find and show glade forms using show_glade()
2) All windows must be named "window1" in glade to be found.
3) Always: require "vrlib"
4) Always: include GladeGUI 


Click the "Run" button to see this in action.  Then click the "Open Project" button
to move on to example 2 ....



