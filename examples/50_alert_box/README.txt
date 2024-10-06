
Alert Box Examples 

The alert() method can be used anywhere in your script.
It is a simple pop-up window that gives the user a message
with optional input.

The most basic example is popping up a message on the screen:

  alert("Hello World")

But it can do much more using optional parameters.  

You can add a headline or title:

  alert("Nice to see you", headline: "Hello World")


It has the option to have additional buttons:

  button_yes:    (returns data or true)
  button_no:     (returns false)
  button_cancel: (returns nil)

So you can program it to do anything with those options:

  answer = alert("Hello", button_yes: "Hi", button_cancel: "Goodbye")

This will show an alert pop-up with a button saying "Hi" and "Goodbye"
And it will return a value for the button clicked.
You can write code to respond to clicking these buttons.

You have several options to get users to input data using the :data option:

  answer = alert("Enter your name:", data: "Name goes here...")

This will return a string for the name.  There are a few ways to ask for data
in alert().  It depends on the type of data you send it.  In the last example, 
we sent it a String, and it shows a Gtk::Entry to edit the string.  You can also
pass it an array or a hash:

String  ==>  Entry box
Array   ==>  Drop Down chooser menu
Hash    ==>  Multiple Entry Boxes

Press the Run button to see them in action.

Most of the time, you'll just use a simple "ok" and "cancel" button, but you have
the option to add a :no_button to do any other task:

  answer = alert("Enter name/password:", data: { name: "", password: ""}, button_no: "Forgot Password")

Now there is a third button to do something else if they forgot their password.

Here are all the optional options:

 :buton_yes = label for button that returns true (default: "Ok", "Save" when input_text is set))
 :button_no = label for button that returns false (default "Cancel" when input text is set)
 :button_cancel = label for button that returns nil
 :data = data for user to edit.  (String, Hash, or Array)
 :width = with of window (used to make longer messages with wrapping look good.)
 :title = title of the window (appears in bar at top) Default = :headline
 :headline = large text that appears at the top.
 :parent = reference to parent window.  Alert box will always be on top of this parent. Usually=self!







