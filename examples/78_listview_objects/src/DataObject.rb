#  This is a basic object that contains data.  Using visualruby, you can easily
#  load your objects into a listview and manipulate them.  You just define one
#  of the colums's type as the object's name (here DataObject) and it will appear in the 
#  ListView.

class DataObject

  include GladeGUI

  def initialize(name, address, email, phone)
    @name = name
    @address = address
    @email = email
    @phone = phone
  end

  def buttonSave__clicked(*args)
    get_glade_variables()
    @builder["window1"].destroy
  end

# The each_cell method defines the appearance of the object in the
# ListView.  You can change the background to red for example to flag the object.
# Here the invalid emails will be shown with a yellow background.  Try entering an invalid
# email, and you'll see it will turn yellow.

  def each_cell(col, ren, model, iter)
    ren.text = "#{@name}  (#{@email})" 
    ren.background = email_valid? ? "white" : "pink"
  end


  def email_valid?
      @email =~ /\A[\w\._%-]+@[\w\.-]+\.[a-zA-Z]{2,4}\z/  
  end


end
