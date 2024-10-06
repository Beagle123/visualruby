##
#  This file shows all the widget types that auto-fill when you
#  call the show_glade() method.   This provides a great shortcut
#  for assigning initial values to widgets in your forms.
#
#  So when you might normally write:
#  
#  @builder["window1"].title = "All Widgets"
#
#  instead you can write:
#
#  @window1 = "All Widgets"
#

class AllWidgets

  include GladeGUI

  def before_show()
    @builder["checkbutton1"].label = "I'm a Check Button" #this could be set in glade
  end

  def initialize()  
    @window1 = "Showing All Widgets"
    @label1 = "I'm a Label"
    @checkbutton1 = true
    @image1 = "src/splash.png"
    @linkbutton1 = "https://beagle123.github.io/visualruby/"
    @entry1 = "I'm an Entry Box"
    @progressbar1 = 0.85  # text property set in glade
    @textview1 = "I'm a Textview"
    @spinbutton1 = 10.5
    @fontbutton1 = "Courier 10"
    @calendar1 = DateTime.new(2011, 5, 14)    
  end  


end

