# 

class CurrencyObject

  def initialize(value)
    @value = value
  end

# The to_s method defines how this object appears in the ListView.
# Think of it like an icon.  It should be a short representation
# of the object.  

  def to_s
    @value.to_s
  end

# The visual_attributes method defines the appearance of the object in the
# ListView.  You can change the background to pink for a negative balance.

  def visual_attributes()
    background_color = @value < 0 ? "pink" : "white"
    { background: background_color }
  end

end
