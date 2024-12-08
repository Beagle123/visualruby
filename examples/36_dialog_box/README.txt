
DIALOG BOXES

Dialog boxes offer the ability to present questions to the user and wait
for the answer.  They are simply a Gtk::Window that has a run() method that
blocks the main event loop, and waits for a response.

The alert() method in visualruby uses a dialog box because it needs to wait for
the user input before proceeding. (see alert_box example)

In fact, the vast majority of the time, you won't need to write your own dialog
box becuase you can just use the alert() method.

This example, shows a situation where you're asing for a boolean input, so it
isn't supported by the alert() method.  So, here you can just create a custom
dialog box with a boolean input.

These dialog boxes can be as extensive as you like.


The run() method returns a Gtk::ResponseType object.  It has several preset return values.
You can see a list of them here: 

https://docs.gtk.org/gtk3/enum.ResponseType.html

You need to set the "Response ID" of each button to tell it which value to return.
Here, there is a "OK" button with a response id = OK.  That means that when you click it,
the run() method returns GTK::ResponseType::OK


