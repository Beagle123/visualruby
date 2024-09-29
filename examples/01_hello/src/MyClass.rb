
class MyClass #(change name)
 
  include GladeGUI 

  def ui_hello_btn__clicked(*args)
    @builder["ui_hello_btn"].label = "Goodbye World" 
  end

end

