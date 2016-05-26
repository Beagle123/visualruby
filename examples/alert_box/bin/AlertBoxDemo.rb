
#  Simple alert examples.  Alert box returns true, false or nil for "x" button.
#  If the flag :input_text is set, it will show a textbox.  Then it will return
#  the String value of the textbox, false or nil.
#
#	  Returns:
#	 	true or String = :button_yes pressed
#		false = :button_no pressed
#	  nil = "x" button closed window
#
class AlertBoxDemo 

 
	include GladeGUI

	def buttonSimple__clicked(*a)
		alert "I'll be back"
	end

	def buttonYesNo__clicked(*a)
		if alert("Do you wnt to continue?", :button_yes => "Yes", :button_no => "No")
			alert "Ok we'll contine..."
		end
	end

	# input boxes will return the string entered, false, or nil for "X" button:
	def buttonInput__clicked(*a)
		if answer = alert("Enter your full name:", :input_text => "Ralph", 
											:button_yes => "Go", :headline => "Enter Name")
			alert "You entered:\n" + answer
		elsif answer == false
			alert "You pressed the Cancel button"
		elsif answer.nil?
			alert "You pressed the 'X' button"
		else
			alert "Error: Should return String (yes), false (no) or nil (quit button)"
		end
	end

	def buttonQuestion__clicked(*a)
		if answer = alert("Your pants are on fire.  What do you want to do?", 
			:button_yes => "Jump in Pool", :button_no => "Panic!", :title => "Pants on Fire", :headline => "Warning")
			alert "Get going!"
		end
	end


	def buttonQuit__clicked(*a)
		@builder[:window1].destroy
	end

end

