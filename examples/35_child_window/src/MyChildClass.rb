##
#  This is just a generic window that gets opened as either modal 
#  or non-modal.  
#

class MyChildClass 

  include GladeGUI

  def initialize(title, message)
      @labelMessage = message
      @window1 = title
  end
  


end

