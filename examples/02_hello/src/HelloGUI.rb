
class HelloGUI 
 
  include GladeGUI 

  def ui_hello_btn__clicked(*args)
    alert("Hello World")
  end

end

