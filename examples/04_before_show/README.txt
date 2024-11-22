
The before_show() method

When you create a form, you'll often want to initialize it with data.

However, the initialize() method can't be used to set-up your form because the @builder
variable hasn't been created yet.  In the initialize() method, @builder = nil!
So you must use the before_show() method because it runs after initialize() and
before the show() method.

The before_show() method is automatically called just before a form is shown
on the screen.  It gives you an opportunity to set-up your form with data, just before
being shown.  It is optional, but if you write a before_show() method, it will 
automatically be called when you call the show_glade() method.  
There is no need to explicitly call it.


Typically in the before_show() method, you populate your form:

  def before_show()
    @view = VR::ListView.new(...)
    @builder["scrolledwindow1"].add_child(@view)  # add custom listview to scrolledwindow1
    @builder["button1"].label = get_customer_name()
  end

Anything can be done because you have the @builder variable which references everything
on the form.
