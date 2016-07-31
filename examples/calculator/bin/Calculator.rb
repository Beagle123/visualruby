##  
#  This class is a GUI for a calculator. 
#  
#  The instance variable, @builder is a reference to the
#  Gtk::Builder object.  @builder["window1"] is a reference to
#  the main window of the calculator.  So, if you edit
#  the Calculator.glade file (using glade) you'll see that
#  the top window is named "window1."  (Always keep the name
#  "window1"!)
#  
#  In glade, you'll see that the names of the keys are:
#  
#  button[0]
#  button[1] ...etc.
#  
#  This corresponds to the array @button.  Visual Ruby's GladeGUI interface
#  will automatically load the values of the array into the form when the
#  show_glade() method is called.
#  


class Calculator

  include GladeGUI

  def before_show()
    @window1 = "Calculator"  #sets window1's title to "Calculator"
    @button =    [  1,  2,  3, "C" ] +
              [  4,  5,  6, "+" ] +
              [ 7,  8,  9, "-" ] +
              [ 0, ".","/","=" ]
    @clear_display = false
  end  

#  This method is called when any key is clicked.  It follows
#  this naming convention: <glade_name>__<signal_name>.  (Separator is
#  two underscores.)  This tells GladeGUI to connect all the
#  "clicked" signals to this method.  It matches the glade
#  names "button", "button[x]" or "Calculator.button[x]" to this method
#  automatically for all the buttons.  Look at the names
#  of the keys in glade by right clicking on Calculator.rb
#
#  This is very useful because you don't need to write a handler for
#  each button!


  def button__clicked(button)
    case button.label
      when "C" then 
        clear_display
      when "=" then
        begin # this doesn't catch all errors
           @builder["display"].text = eval(@builder["display"].text).to_s
        rescue
          @builder["display"].text = "error"
        end
        @clear_display = true
      when /[0-9]/ then
        clear_display if @clear_display
        @builder["display"].text = @builder["display"].text + button.label
      else 
        @builder["display"].text = @builder["display"].text + button.label
    end   
  end  

  def clear_display
    @builder["display"].text = ""
    @clear_display = false
  end


end

