
class AlertBoxDemo #(change name)
 
	include GladeGUI

	def buttonSimple__clicked(*a)
		alert "I'll be back"
	end

	def buttonYesNo__clicked(*a)
		if alert("Do you wnt to continue?", :button_yes => "Yes", :button_no => "No")
			alert "Ok we'll contine..."
		end
	end

	def buttonInput__clicked(*a)
		if answer = alert("Enter your full name:", :input_text => "Ralph", :button_yes => "Go", :headline => "Enter Name")
			alert "You entered:\n" + answer
		elsif answer == false
			alert "You pressed the Cancel button"
		elsif answer.nil?
			alert "You pressed the 'X' button"
		else
			alert "Error: Should return true (yes), false (no) or nil (quit button)"
		end
	end

	def buttonQuestion__clicked(*a)
		if answer = alert("Your pants are on fire.  What do you want to do?", 
			:button_yes => "Jump in Pool", :button_no => "Panic!", :title => "Pants on Fire", :headline => "Warning")
			alert "Get going!"
		end
	end


end

