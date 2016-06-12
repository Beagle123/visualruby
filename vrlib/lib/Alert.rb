
module VR

  class Alert  # :nodoc:

    attr_accessor :answer    

    include GladeGUI
    
    def initialize(message, answer, flags = {})
      @flags = flags
      @answer = answer
      @message = message
      @p = nil

    end

    def before_show
      @flags[:title] = @flags[:title] ? @flags[:title] : @flags[:headline]
      @builder[:window1].title = @flags[:title] if @flags[:title]
      @builder[:window1].resize(@flags[:width],100) if @flags[:width].to_i > 100
      @builder[:headline].show if @flags[:headline]
    
      if text = @flags[:input_text]
        @flags[:button_yes] ||= "Save"
        @flags[:button_no] ||= "Cancel"
        @builder[:input_text].show 
      end 

      @builder[:button_no].show if @flags[:button_no]
      @builder[:button_cancel].show if @flags[:button_cancel]
      set_glade_hash(@flags)
    end

    def button_yes__clicked(but)
      @answer.answer = @flags[:input_text] ? @builder[:input_text].text : true
      @builder[:window1].destroy
    end

    def button_no__clicked(but)
      @answer.answer = false    
      @builder[:window1].destroy
    end

    def button_cancel__clicked(but) #answer stays nil  
      @builder[:window1].destroy
    end


  end

  #so it can be passed by reference
  class DialogAnswer # :nodoc:
    attr_accessor :answer
  end

end  

#  The alert method creates a pop-up alert in your program.  It creates a modal
#  window that halts execution of your code until the user closes it.  Its great
#  for displaying messages and debugging.  It also has the option of displaying
#  a text entry box for getting text input from the user.  This small tool can save
#  hundreds of lines of code in your programs.  It can be used extesnively to
#  display all types of messages and request all types of user input.
#  
#  There is an example project called "alert_box" in the home/visualruby/examples folder
#  that shows several ways to use this versitle method.
#  
#  The alert box can disply 1, 2 or 3 buttons.  The first button is denoted using the symbol: :button_yes
#  button and is always displayed.  You can add a :button_no button and a :button_cancel
#  as well.  The alert method will return a value based on the button pressed:
#  
#   Returns:
#   true or String = :button_yes pressed (returns user input String when its a text entry box)
#   false = :button_no pressed
#   nil = :button_cancel pressed
#   nil = "x" button closed window
#  
#  The first argument is a text message to display.  It is the only required argument.
#  If you just provide a text message, the message will pop-up with a button that says "Ok"
#  that closes the window.
#  
#  The second, optional argument is a hash of flags that can configure the alert box to
#  have much more functionality:
#  
#    :buton_yes = label for button that returns true (default: "Ok", "Save" when input_text is set))
#    :button_no = label for button that returns false (default "Cancel" when input_text is set)
#    :button_cancel = label for button that returns nil
#    :input_text = default text for input box.  Triggers appearance of input box.
#    :width = with of window (used to make longer messages with wrapping look good.)
#    :title = title of the window (appears in bar at top) Default = :headline
#    :headline = large text that appears at the top.
#    :parent = reference to parent window.  Alert box will always be on top of this parent. Usually=self!
#    
#    ALL THESE FLAGS ARE OPTIONAL
#  
#  If you want to add these buttons, just set their values to whatever text you want them to
#  display.  For example, :button_no => "Abort Process" will cause the second button, to display
#  "Abort Process" and if the user clicks it, the alert method will return false.
#  
#  There are many examples in the "alert_box" example project. 
#  
def alert(msg, flags = {})
  @answer = VR::DialogAnswer.new()
  VR::Alert.new(msg, @answer, flags).show_glade(flags[:parent])
  return @answer.answer 
end



