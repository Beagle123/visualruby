

class AlertBoxDemo 

 
  include GladeGUI

  def buttonSimple__clicked(*a)
    alert "I'll be back"
  end

  # Its best to include a parent so alert box always on top.
  # Will return true, false or nil ("x" pressed)
  def buttonYesNo__clicked(*a)
    if alert("Do you want to continue?", :button_yes => "Yes", :button_no => "No", :parent => self) #on top
      alert "Ok we'll contine..."  # not always on top
    else
      alert "Ok we'll abort!"
    end
  end

  # input boxes will return the string entered, false, or nil for "X" button:
  def buttonInput__clicked(*a)
    if answer = alert("Enter your full name:", data: "Ralph", 
                      button_yes: "Go", headline: "Enter Name")
      alert "You entered:\n\n<b>" + answer + "</b>"
    elsif answer == false
      alert "You pressed the <b>Cancel</b> button"
    elsif answer.nil?
      alert "You pressed the <b>'X'</b> button"
    end
  end

  # returns a string, false or nil
  def buttonQuestion__clicked(*a)
    if answer = alert("Your pants are on <b><u>fire</u></b>.  What do you want to do?", :width => 500, :button_cancel => "Quit",
            button_yes: "Jump in Pool", button_no: "Panic!", 
            title: "Pants on Fire", headline: "Warning")
      alert "Get going!\n(alert() returned true)"
    elsif answer == false # Panic
      alert "Start Panicing!\n(alert() returned false)"
    else
      alert "Ok Avoid the question.\n(alert() returned nil)"
    end
  end

  # returns string, false or nil
  def buttonChoices__clicked(*a)
    names = ["Fred Flinstone", "Barney Rubble", "Pebbles"]
    user_id = [ 912343, 893833, 874633 ]
    
    answer = alert("Choose Person:", data: names, button_no: "New Person")
    
    if answer.is_a?(String)
      alert ("You chose: #{answer}\nUser_id: #{user_id[names.index(answer)].to_s}")
    elsif answer == false #no_button pressed = new name
      new_name = alert("Enter New Person:", input_text: "")
    elsif answer.nil?
      alert "You pressed the 'X' button"
    end
  end

  def buttonHash__clicked(*a)
    my_hash = { username: "", password: "" }
    answer = alert("Enter your credentials:", headline: "Sign In", data: my_hash, button_no: "Forgot Password")
    if answer.is_a? Hash
      alert "Alert() Returned Hash:  \n\n" + answer.to_s
    elsif answer == false
      alert "Returned false."  # so get password
    elsif answer.nil?
      alert("Returned nil")
    end
  end  

end

