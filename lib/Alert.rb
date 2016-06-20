
module VR
  # Class that the #alert method uses.

  # @see #alert
  class Alert  

    attr_accessor :answer    

    include GladeGUI
    
    # Just passes on values from #alert method. 
    # @see #alert      

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

    # Helper to VR::Alert so :answer can be passed by reference.
    class DialogAnswer 
      attr_accessor :answer
    end

  end

end  

# @param [String] message text message to display in alert box. Uses markup.
# @param [Hash] options -- Hash of options:  :button_yes => text on the button that returns true.
# @option options [String] :button_yes Text that appears on the "yes" button.
# @option options [String] :button_no Text taht appears on "no" button. (set to make no button appear)
# @option options [String] :button_cancel Text taht appears on "cancel" button. (set to make cancel button appear)
# @option options [String] :input_text Text that appears in entry box. (set to make entry box appear)
# @option options [String] :headline Larger headline over text message.
# @option options [String] :title Title of the alert box window.  Defaults to :headline.
# @option options [Integer] :width The width in pixels of the window for wrapping text. 
# @option options [Object #builder] :parent The window that the alert box is always on top of.
# @return [String] text in the text entry field when the :button_yes button is pressed
# @return [true] When the :button_yes button is selected and there's no text entry box.
# @return [false] When :button_no is pressed
# @return [nil] When :button_cancel os the "X" button is pressed.
# The alert method creates a pop-up alert in your program.  It creates a modal
# window that halts execution of your code until the user closes it.  Its great
# for displaying messages and debugging.  It also has the option of displaying
# a text entry box for getting text input from the user.  This small tool can save
# hundreds of lines of code in your programs.  It can be used extesnively to
# display all types of messages and request all types of user input.
#
# @example
#  alert("Continue?", button_no: "Nope", button_cancel: "Quit", parent: self) 
# 
# @example
#  alert "The file you selected is already on disk.  Do you want to overwrite it?",
#    headline: "Overwrite FIle?",
#    button_yes: "Overwrite",
#    button_no: "Reload From Disk",
#    button_cancel: "Cancel"
# 
# http://visualruby.net/img/alert_overwrite.jpg  
#   
# The alert box can disply 1, 2 or 3 buttons.  The first button is denoted using the symbol: :button_yes
# button and is always displayed.  You can add :button_no and :button_cancel.      
# If you want to add these buttons, just set their values to whatever text you want them to
# display and they will appear.  Likewise, if you add the option, :input_text, a text entry box will
# appear.
#      
# There are many examples in the "alert_box" example project. 

def alert(message, options = {})
  @answer = VR::Alert::DialogAnswer.new()
  VR::Alert.new(message, @answer, options).show_glade(options[:parent])
  return @answer.answer 
end



