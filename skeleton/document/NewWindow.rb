
class MyClass #(change name)

  include GladeGUI

  #code that runs immediately before the #show method of this class
  def before_show()
    @var1 = "Hello World"
  end  

  def   widget__clicked(*args)
    #code that runs when widget named "widget" in glade is clicked. 
  end

end
