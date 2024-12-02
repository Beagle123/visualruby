# @title Quick Start
# Quick Start 

## 1) Install Visual Ruby

First [Install Ruby, Glade, and Visualruby](file.Download.html). Once you've installed it, run it by typing the command:
```
	vr
```
<p>
  <iframe width="480" height="360" src="https://www.youtube.com/embed/cFejLEs5Rb0" frameborder="0" allowfullscreen>
  </iframe>
</p>

## Go to the Example Projects

The best way to learn what you can do with visualruby is to run the example projects.
Start by reading the README.txt file located in the first project.  Each example
will illustrate a few features.  Then click the "Run" button to try the example.

## Navigating the IDE

You can right-click on the files in the left column to see the options.  If you right-click
on a ruby script, you can set it to be the main program that will run when you hit the "Run"
button.  The main program will appear in bold text.


## Visual Ruby Home Folder

When installed, visualruby will create a folder:

    /home/yourname/visualruby

This is where you should keep all your visualruby projects.

When you create a project in the /visualruby folder, it will then appear
when you click the Open Project button on the toolbar.  

## Try Editing the Glade Files

Try right-clicking on a .rb file, and edit its glade file.  You'll see that the glade
file's name maps the glade file name to the class of the calling file:

    MyClass.rb => MyClass.glade


## Learn Gtk

Visualruby is written entirely in Gtk, so every part of visualruby is a subclass of a Gtk object.
Therefore, you have the entire Gtk library of classes that can be used in visualruby.  Also,
all the properties and methods of the Gtk parent classes can be used on the visualruby classes.

For example, the class VR::ListView is a subclass of Gtk::TreeView.  So you can use all of Gtk::TreeView's
methods and instance variables.
   

## Getting Help

There are several resources to get help, and I will be happy to answer your questions.
However, I want to answer questions publicly so others can benefit as well.  Please post
to one of there forums:


[Ruby Gnome Forum](http://www.ruby-forum.com/forum/gnome2)

[Stack Overflow](StackOverflow.com)

[Visual Ruby's Git Hub Page](http://github.com/Beagle123/visualruby)








