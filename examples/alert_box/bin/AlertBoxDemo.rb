
#  Simple alert examples.  Alert box returns true, false or nil for "x" button.
#  If the flag :input_text is set, it will show a textbox.  Then it will return
#  the String value of the textbox, false or nil.
#
#    Returns:
#     true or String = :button_yes pressed
#    false = :button_no pressed
#    nil = "x" button closed window
#
#  
#  the flags for the alert() method are:
#  
#  :buton_yes = label for button that returns true (default: "Ok", "Save" when input_text is set))
#  :button_no = label for button that returns false (default "Cancel" when input_text is set)
#  :button_cancel = label for button that returns nil
#  :input_text = default text for input box.  Triggers appearance of input box.
#  :width = with of window (used to make longer messages with wrapping look good.)
#  :title = title of the window (appears in bar at top) Default = :headline
#  :headline = large text that appears at the top.
#  :parent = reference to parent window.  Alert box will always be on top of this parent. Usually=self!
#  
#  ALL THESE FLAGS ARE OPTIONAL

class AlertBoxDemo 

 
  include GladeGUI

  def buttonSimple__clicked(*a)

path = ENV["HOME"] 
    alert("The example projects are installed in this folder:\n\n<b>#{path}</b>\n\n "+
      "Use your <b>/home/visualruby</b> folder for all your visualruby projects.", 
      :parent => self,  
      :headline => "Installing Example Projects...",
      :width => 500)

    alert "I'll be back"
  end

  def buttonSimpleInput__clicked(*a)
    alert("Enter your age:", :input_text => "")
  end

  #its best to include a parent so alert box always on top:
  def buttonYesNo__clicked(*a)
    if alert("Do you want to continue?", :button_yes => "Yes", :button_no => "No", :parent => self) #on top
      alert "Ok we'll contine..."  # not always on top
    end
  end

  # input boxes will return the string entered, false, or nil for "X" button:
  def buttonInput__clicked(*a)
    if answer = alert("Enter your full name:", :input_text => "Ralph", 
                      :button_yes => "Go", :headline => "Enter Name")
      alert "You entered:\n\n<b>" + answer + "</b>"
    elsif answer == false
      alert "You pressed the <b>Cancel</b> button"
    elsif answer.nil?
      alert "You pressed the <b>'X'</b> button"
    else
      alert "Error: Should return String (yes), false (no) or nil (quit button)"
    end
  end

  def buttonQuestion__clicked(*a)
    if answer = alert("Your pants are on <b><u>fire</u></b>.  What do you want to do?", :width => 500, :button_cancel => "Quit",
      :button_yes => "Jump in Pool", :button_no => "Panic!", :title => "Pants on Fire", :headline => "Warning")
      alert "Get going!"
    end
  end


  def buttonQuit__clicked(*a)
    @builder[:window1].destroy
  end

end

