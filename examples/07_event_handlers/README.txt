
This demonstrates how visualruby handles events.

An example of an event is when a user clicks a button.
The button itself is an instance of Gtk::Button, and it has an event
associated with it called "clicked".  When the user clicks the 
buttion, the "clicked" event occurs, calling a method to take some action.

The code would look like this if you did everything without the benefit of
visualruby or glade:

  @button = Gtk::Button.new(:label => "Say hello")
  @button.signal_connect "clicked" do |_widget|
    puts "Hello World!!"
  end

You are free to write code like this.  However, its much easier and faster in visualruby.

With visualruby, you can create your button in glade exacly how you like it, then
give it a name like:  ui_hello_but.  Then you can write a method for
the ui_hello_but by simply using this naming convention:

  def ui_hello_but__clicked(*args)   # two underscores!
    puts "Hello World!!"
  end

Visualruby will automatically find this method, and execute the code based
on the method's naming convention.

It takes the form:

  object__event_name(*args)  # *args just captures arguments, often ignored

When you run your program,  visualruby will look at all the names of methods,
and if it sees a name that has 2 underscores,  it will look for an
object and an event to match it to.  In our example, it would find the method,
#ui_hello_but__clicked, and see that ui_hello_but is a button on the glade
form, and the button has a matching "clicked" event.  So it would run this code
when the user clicks the button.

Visualruby would run this code under the hood:

  @builder["ui_hello_but"].signal_connect "clicked" do |*args|
    ui_hello_but__clicked(*args)
  end

So you don't need to hard code everything, just use the right names.

There are three different forms the method name can take:

1) the one described above 

2) It will call event handlers based on an instance variable name:

  @var = @builder["ui_hello_but"]  # var is instance of Gtk::Button
  def var__clicked(*args)
    puts "Hello World"
  end

3) If your class is a subclass of a Gtk::Button:

  class MyClass
    ...
    @button = MyButton.new(label: "Hello")  # necessary step!
  end

  class MyButton < Gtk::Button
    ...

    def self__clicked(*args)
      puts "Hello World"
    end

  end

Note:  it is necessary to have an instance variable that refers to
your button in order for visualruby to find the self__xxxxx methods.
If you just insert it into a form, there will be no reference to it.

Using this method, you can write your own custom subclass of Gtk::TextView
and use it whereever you want.




