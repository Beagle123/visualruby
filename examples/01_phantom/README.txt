
To start, click the "Run" button, and the program will appear.

Clicking the run button, simply runs this command: 

ruby phantom.rb

You can see and edit the "Run" command in menu:  Tools > Project Settings 

Try right-clicking on the files on the left to see options.

Next, try editing a glade file by clicking on the glade folder,
and double clicking on Phantom.glade.  If this does't work,
you need to install the Glade Interface Designer.  Glade needs to be installed
such that it runs from the command prompt using the command, "glade"

These lines of code are what makes the program work:

require 'vrlib'
 
and

include GladeGUI

The GladeGUI module is in vrlib.rb, and it contains the vital methods
to transform a class into a GUI program.

One important method in GladeGUI is the #show_glade() method.  It reads the
glade file, and shows it on the screen. 

So this line of code:

Phantom.new.show_glade()

Creates an instance of the Phantom class, then loads Phantom.glade, then
finds a window with ID "window1" in the glade file, and show it onscreen.
  

Summary:
1) Always require "vrlib" in your programs.
2) Then, include GladeGUI to any class that has a GUI.
3) Visualruby will automatically find the glade files in the glade folder.
4) It will load the glade file, find ID "window1", and show it. 


Click the "Run" button to see this in action.  Then click the "Open Project" button
to move on to example 2 ....



