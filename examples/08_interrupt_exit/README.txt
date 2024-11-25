
Closing Windows

Visualruby has some helpful features to handle closing windows.

First, you can make a "cancel button" on any form by simply giving
it the glade name:

cancelButton

Any button with that name will be recognized, and its window will be closed automatically
when you press it.  This is nice because you don't need to clutter your code with
a method named "cancelButton__clicked()" on every form.

However, sometimes it's desirable to interrupt the window closing process
to avoid data loss.  Sometimes, you want the program to confirm that
the user wants to discard the data on the form.  Usually, asking, "Are you sure you want to close?"

There's a GTK event named "delete_event" that is fired before the window is destroyed.
You can write this method to run before the window is destroyed:

  def window1__delete_event(*a)
    answer = alert("Do you really want to leave?", button_yes: "Yes!", button_no: "No")
    if answer == true
      return false  # will close window
    else
      return true   # abort and stay here
    end
  end

Remember, that ALL windows have the name "window1"

If this method returns false, the window closes.  If it returns true, it leaves the window
open.  You can try it for yourself by hitting the "run" button now.

So the "destroy" method will kill the window without asking, but all the "close" requests will
be interrupted, and run the window1__delete_event() method.



