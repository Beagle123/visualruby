
class InterruptExit
 
  include GladeGUI

  # The main window is always window1
  # the delete_event is fired when you click the "X" button.
  def window1__delete_event(*a)
    answer = alert("Do you really want to leave?", button_yes: "Yes!", button_no: "No")
    if answer == true
      return false  # will close window
    else
      return true   # abort and stay here
    end
  end

end

