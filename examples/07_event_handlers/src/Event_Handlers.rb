
class Event_Handlers  
 
  include GladeGUI

  def before_show()
    @my_var = @builder["ui_use_variable_but"]

    @txt = MyTextView.new()
    @txt.visible = true

    @txt.buffer.text = "Try clicking on the buttons and text area." +
                       "\nIt will tell you what method gets called." +
                       "\nWhen the TextView gets focus, it will allow editing."

    @builder["scrolledwindow1"].add_child(@txt)

  end

  def ui_normal_but__clicked(*args)
    @txt.buffer.text += "\nCALLED:   ui_normal_but__clicked()"
  end
  
  # this will work because it will find @my_var as a Gtk::Button
  def my_var__clicked(*args)
    @txt.buffer.text += "\nCALLED:   my_var__clicked()"
  end
  
  # this will work because @txt is an instance of Gtk::TextView
  def txt__cut_clipboard(*args)
    alert "Cut Clipboard"
  end


end

