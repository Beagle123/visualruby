
class CalculatorGUI

  include GladeGUI

  def before_show()
    @window1 = "Calculator"  #sets window1's title to "Calculator"
    @button = [ 1,  2,  3, "C" ] +
              [ 4,  5,  6, "+" ] +
              [ 7,  8,  9, "-" ] +
              [ 0, ".","/","=" ]
    @clear_display = false
    @display = @builder["ui_display_ent"]
  end  


  def button__clicked(button)  
    case button.label
      when "C" then 
        clear_display
      when "=" then
        begin # this doesn't catch all errors
           @display.text = eval(@display.text).to_s
        rescue
          @display.text = "error"
        end
        @clear_display = true
      when /[0-9]/ then
        clear_display if @clear_display
        @display.text = @display.text + button.label
      else 
        @display.text = @display.text + button.label
    end   
  end  

  def clear_display
    @display.text = ""  # same as @builder["ui_display_ent"].text = ""
    @clear_display = false
  end


end

