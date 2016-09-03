# @title Child Window Tutorial 

# Child Windows

There is an excellent example project named **child_windows** included with visualruby.
To try it, click on the **Open Project** button.

Child windows are simply windows that you open from your main program.

There are 2 types of windows you can use:

1. **Modal Windows** -- Windows that halt the main program until they are closed.
2. **Modeless Windows** -- Windows that operate simultaniously with their parent.

You can select which type of window to use in glade:

![](http://visualruby.net/img/modal.jpg)

Just check or un-check the **Modal** checkbox to set which type of window you prefer.

The type of window that you open will depend on the situation:

## Modal Windows

The benefit of using modal windows is that they will halt your program's execution until they're closed.
This behavior is often desireable when you don't want users to be able to make any changes while
the child window is open.  A good example of this is visualruby's alert box:

![](http://visualruby.net/img/alert_overwrite.jpg)

The program will insist on getting an answer from the user before doing anything.

Also, you should always set a parent window for all modal child windows so the child
will always appear on top of the parent window.  This is always desirable behavior because
you don't want to allow the parent to appear on top of the child while the parent is frozen.
If the parent window hides the child window, the user will be confused because the parent will
not respond to mouse clicks until the child is closed.  Therefore, make sure to set a parent
window for all modal child windows so the user always sees the child that is insisting on a response.

To create a modal child window, set its **Modal** property to true in glade (see above).
Then simply open it using code:

    win = MyModalChildWindow.new
    win.show_glade(self)  # self = parent window

Here, the reference to **self** makes the child window always appear on top of the window, **self**.
 
## Modeless Windows

Modeless Windows are simply windows that function simultaneously with the main window.  An
example of modeless windows is a word processor where you want to have several open documents
that function independently from each other, and you are free to switch between them.

To open a modeless window, simply un-check the **Modal** property in glade (see above), and open
it normally.  The window will function along side to the main program.

Usually, you don't want to set a parent window for a modeless window because you want to allow the user
to bring the main window to the top, and have the child appear behind it.

So the code to open a modeless window looks like this:

    win = MyModelessChildWindow.new
    win.show_glade()  

Note that the #show_glade method doesn't pass a parent window, so either window can appear on top.

## Returning a Value From a Modal Window

One of the benefits of modal child windows is that your main program
can wait until the child window returns a value.  This can
make them function like dialog boxes.

When you halt the parent window you can return a value
from the child window to the parent:

    @value = nil
    win = ChildWindow.new(self)  # ChildWindow is a class you define.
    win.show_glade(self)  # program halts.  Sets value of @value
    if @value = "Value Now Set!" then
       ...your code here
    end

The ChildWindow class sets the value of @value before closing:

    class ChildWindow
       def initialize(parent)
         @parent = parent
       end

       def buttonSave__clicked(*a)
         @parent.value = "Value Now Set!"
         @builder[:window1].destroy
       end
    end

So, when the user clicks the buttonSave button, it sets the @value variable that your program can respond to.
This is how visualruby's **#alert** method works.  It freezes the main program, and returns the value
from the user.

## Modeless Window With Parent

Rarely, you may want to open a modeless window that functions simultaneously with the main
program, but always appears on top of it.  An example of this behavior would be a "Search and Replace"
window in a text editor where you want the ability to edit the text in the editor without
the "Search and Replace" window disappearing behind the editor window.

To acheive this behavior, simply set the **Modal** property to true (checked) and pass a reference
to the parent to the #show_glade method:

    search_replace_win = SearchWindow.new
    search_replace_win.show_glade(self)  # self = parent window

Now the search_replace_win window will always be on top of the **self** window.

