
class MyClass #(change name)
 
  include GladeGUI

  def before_show()
    @button1 = "Hello World"
  end  

  def button1__clicked(*args)
    @builder["button1"].label = "Goodbye World" 
  end

end

