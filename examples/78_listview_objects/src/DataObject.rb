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


  def buttonCancel__clicked(*args)
    @builder["window1"].destroy
  end


#The to_s method defines how this object appears in the ListView.
#Think of it like an icon.  It should be a short representation
#of the object.  Then when the user clicks on it, they get the full object

  def to_s
    "#{@name}  (#{@email})"
  end

#The visual_attributes method defines the appearance of the object in the
#ListView.  You can change the background to red for example to flag the object.
#Here the invalid emails will be shown with a yellow background.  Try entering an invalid
#email, and you'll see it will turn yellow.

  def visual_attributes()
    background_color = email_valid? ? "white" : "pink"
    { background: background_color }
  end

  def email_valid?
      @email =~ /\A[\w\._%-]+@[\w\.-]+\.[a-zA-Z]{2,4}\z/  
  end


end
