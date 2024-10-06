# @title Signals Tutorial

= Signals Tutorial

== Visual Ruby handles signals Using a Naming Convention.

Signals are events that occur when a user interacts with your program.
For example, when a user clicks on a button, a "clicked" signal occurs.
You need to write code that reacts to the user clicking the button, and 
takes the proper action.

Visual Ruby uses a simple naming convention for methods that react to signals.

Just write a method like so:

  def button1__clicked(*args)
    puts "Do something"
  end

And that's it!  

When the user clicks the button, the program prints "Do Something"

This assumes that you have a button in your glade form named **button1**.  Then visualruby
attaches the button's "clicked" signal to this method.  The two underscores in the
method's name indicate that this method will handle a signal using the maming convention *widget__signal*.

There's no need to assign signal handlers in glade, or use Gtk's **#signal_connect** method because
all the signal handling will be done automatically when you use this naming convention.

Other examples of signal handlers are:

  def listview1__row_activated(*args)
    # user double clicked on a row in a Gtk::Listview
  end

  def notebook1__changed(*args)
    # user selected tab in Gtk::Notebook
  end

  def menuOption1__activate(*args)
    # user selcted menu option named "menuOption1"
  end

There are hundreds of events to use.  See Gtk's documentation for each widget to see what signals it uses.

The **args** splat is the arguments passed by the signal.  They are different for each widget.  For example,
the Gtk::Button widget's clicked signal passes a single argument:  a reference to the button itself.

==Attach Signals to instance variables

This method also works on instace variables that contain references to widgets.
For example, visualruby offers a great class VR:ListView for displaying
rows of data.  It has a signal named "row_activated" for when a user double-clicks
a row in the grid.  So, we can simply use the same naming convention, and the
"row_activated" signal will be handled automatically:

  class MyClass
   
    include GladeGUI

    def before_show  # 
     @list_view = VR::ListView.new(:myfield => String)
     @list_view.add_row(:myfield => "Hello World")
     @builder["scrolledwindow1"].add_child(@builder, @list_view)
    end

    def list_view__row_activated(*args)
     row = @list_view.selected_row()
     puts row[:myfield]  # =>  "Hello World"
    end

  end

When the user double clicks on "Hello World" in the listview, it outputs "Hello World" to the
console.

By naming the method "list_view__row_activated" its telling GladeGUI to attach the 
"row_activated" signal to @list_view.  We're telling it to do this by separating
the names by two underscores.

==Attaching signals to "self"

Often, you will prefer to subclass VR::ListView (and its good coding practice).
So, you'll need a way to attach signals to "self."  Luckily, you can do that
by simply using "self" as the glade_name:

  class MyListView < VR::ListView

    include GladeGUI

    def initialize(rows)

      parse_signals()  # activates self__row_activated method
      add_row(:myfield => "Hello World")
      @builder["scrolledwindow1"].add_child(@builder, self)
    end

    def self__row_activated(*args)
      row = selected_row()
      puts row[:myfield]  # =>  "Hello World"
    end

  end

Notice that MyListView is a subclass of VR::ListView which is a subclass of Gtk::TreeView which emits a
signal called "row_activated" when the user double-clicks on a row.
So, we're trying to attach the "row_activated" signal of "self."  Therefore we changed the name of our method
to "self__row__activated"  Now when the superclass, Gtk::TreeView emits its "row_activated" signal, this method is 
called.

Note:  In this case, we needed to call the parse_signals() method manually.  Normally, the parse_signals()
method is called automatically by the show_glade() method when the main window is shown.  However, 
this class isn't a window, so we're never going to call show_glade on it.  THerefore, we need to run
parse_signals() to get the self__row_activated method to work. 

==Attaching Signals to a method

Once in a while, you may need to set a signal to a method.  The method must return
an object that will respond_to?("signal_connect").  In other words,  When GladeGUI
encounters a method name that has 2 underscores in it, its going to try to
connect a signal to the object.  For example. if it sees the method "button1__clicked:"

```ruby
     # method_name = "button1__clicked"

     obj_name = "button1"
     if defined(obj_name)
       obj = eval(obj_name)
       if obj.respond_to?(:signal_connect)
         obj.signal_connect("clicked") { |*args| method(obj_name).call(*args)) } 
       end
     end
```

So, first it tests to see if "button1" is defined.  Then it tests to see if "button1"
has a "Signal_connect" method.  Then when it knows that "button1" can have a signal attached to
it, it attaches the "clicked" signal to it.


[Rule]
  Use the naming convention:  *obj_name__signal*   for anything that can have a signal attached to it.

Here's an example of were it can be very useful:  The VR::ListView class has a weird way of handling
when the user selects a new row.  For some reason the poeple who designed its parent, Gtk:TreeView,
decided to make a separate object to handle selections.  To reference this object, you
call the Gtk::TreeView#selection method:

 class MyClass < MyListView
   
   include GladeGUI

   def show
     @builder["scrolledwindow1"].add_child(@builder, self)
     add_row("Hello", "World")
     add_row("Hello", "Mars")
     load_glade(__FILE__) #must be called after @list_view is set!
     show_window
   end

   def self__row_activated(*args)
     row = selection.selected  #this selection method returns the object
     puts row[0] + " " + row[1]  # =>  "Hello World"
   end

 end

Here, the reference to "selection.selected" line calls the Gtk::TreeView#selection
method that returns a Gtk::TreeSelection object.  The "selected" call retruns the
currently selected row.  But the important thing to realize here is that our 
VR::ListView class has a #selection method that returns a Gtk::TreeSelection
object, and we can attach signals to that object.

Now suppose that we wanted to wanted to display some text on the screen when the
selection changes.  So when the user selects a different row, the text being displayed
on the screen changes.  For this we'll need to use the Gtk::TreeSelection#changed
signal.  


Name we want to attach signal to = "selection"

Name of signal to attach = "changed"

So our method name would be "selection__changed:" (2 underscores!)

 class MyClass < MyListView
   
   include GladeGUI

   def show
     @builder["scrolledwindow1"].add_child(@builder, self)
     add_row("Hello", "World")
     add_row("Hello", "Mars")
     load_glade(__FILE__) #must be called after @list_view is set!
     show_window
   end

   def selection__changed(*args)
     row = selection.selected  #this selection method returns the object
     puts row[0] + " " + row[1]  # =>  "Hello World" or "Hello Mars"
   end

 end

This program would output the current row everytime the user selected a new row.
So, it would output "Hello World" and "Hello Mars" over and over again.

== Two important methods for VR::ListView and VR::TreeView

When you subclass VR::ListView, there are two method names you should remember:

 def self__row_activated(*args)
 def selection__changed(*args)

These names will always be the same, and they will be very useful because you often want
to have your program respond to double-clicking a row or when the selection changes.

== Signal Handler for Multiple Widgets 

The GladeGUI#load_glade method will automatically fill-in arrays of data into
a glade form. See Calculator example project for more)  But when 
you use arrays of data, you will also have to have
many names for these widgets in glade, and you may need to
attach a signal to each one. 
However, visualruby gives you the ability to have one signal
handler for all the widgets. 

Here is a portion of the Calculator project as an example:

 class Calculator

   include GladeGUI

   def before_show()
     @builder["window1"].title = "Calculator"
     @keys = [ 1, 2, 3, "C" ] +
             [ 4, 5, 6, "+" ] +
             [ 7, 8, 9, "-" ] +
             [ 0, ".","/","="]
   end	

   def keys__clicked(button)
     # handle the keypress 
   end	

 end 


http://visualruby.net/img/signals_calculator.jpg


In the glade form, there are 16 buttons with the names:

  "keys[0]"
  "keys[1]"
  "keys[2]"
  etc...

There is a @keys instance variable that maps to the 16 glade buttons.  The all the labels on the buttons are
set when the show_glade method is called on this class.  When visualruby parses the signals for widgets that
have have the array brackets in the name it will call he same signal handler:  *keys_clicked* for all
16 buttons.

Also, remember that the @keys variable has no impact on this.  This is just GladeGUI scanning
the names of the widgts, and matching them to your signal methods (denoted with
2 underscores).

See the calculator example for more.
