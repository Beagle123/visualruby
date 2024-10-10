
Using get_glade_variables and set_glade_variables

Visualruby uses the universal @builder variable to hold references
to all the GUI components on the glade form.  So you can retreive
the instance of a widget by using its glade name:

@builder["ui_customer_ent"].text = "Harry"

This would likely be a Gtk::Entry for a customer'n name now set to show "Harry".

However, usually there will be many fields on the form that need to be filled beyond 
customer (e.g. address, phone, email etc.)  To initialize your form, you would need 
to populate the fields like this:

  def before_show()
    @builder["ui_customer_ent"].text = "Harry"
    @builder["ui_customer_id_ent"].text = "4356444"
    @builder["ui_customer_address_ent"].text = "3424 Main St"
    # etc.
  end

Then those values would show on the screen.

However, visualruby will do this for you automatically using a method named
set_glade_variables.  To use it you just need to create instance variables 
with the same names as your widgets in glade:

  def initialize
    @ui_customer_ent"    = "Harry"
    @ui_customer_id_ent  = "4356444"
    @ui_customer_address = "3424 Main St"
  end

Then, when the #show_glade method is called, it will automatically call #set_glade_variables
to do this:


    @builder["ui_customer_ent"].text          = @ui_customer_ent
    @builder["ui_customer_id_ent"].text       = @ui_customer_id_ent
    @builder["ui_customer_address_ent"].text  = @ui_customer_address_ent
    # etc.

It will simply match the names of the instance variables to the glade names
and fill in the values on the form.  All with zero lines of code.  

There is also a method named #get_glade_variables that retreives the values
from the form and updates the instance variables with any values that
the user changed on the form.

This saves even more typing and errors.  You can replace this:

  @ui_customer_ent          =    @builder["ui_customer_ent"].text           
  @ui_customer_id_ent       =    @builder["ui_customer_id_ent"].text       
  @ui_customer_id_address   =    @builder["ui_customer_address_ent"].text  

with this:

  get_glade_variables

Now you can save to a database etc.

So the general procedure is to create a list of instance variables in the #initialize method,
then visualruby will update the form with the values.  When done, retreive the values
using #get_glade_variables.  An added benefit is that it creates
a nice list of the fields on the form so you don't need to look them up in glade.

This process can be done with many widgets including buttons, images, calendar dates, entries
etc.  You can see this in the next example.  Later, click on "Open Project" and see the "all_widgets"
example.


