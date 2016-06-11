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
  
  # When cancel clicked in MyChildClass.glade
  def buttonCancel__clicked(*args)  
    @builder["window1"].destroy 
  end

end

