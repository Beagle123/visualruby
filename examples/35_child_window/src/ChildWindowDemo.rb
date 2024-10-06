 
##
#  This is a "main" GUI class for a program.  It allows you
#  to open modal and non-modal windows.  
#
#  Modal windows are
#  windows that appear on top of the main program window and
#  halt the main window until they are closed.  They're good for
#  dialogs etc.  
#
#  Normal non-modal windows operate concurrently with the main
#  window and each other.  You can open many child windows, and they 
#  will all function at the same time.  For example, they're useful if you're
#  opening several documents at the same time.
#  
#  To open a modal window, set the "modal" property in glade then call the show_glade() 
#  method with the parent
#  as the aregument.  Almost always, you will be calling the show method
#  from within the parent window so you would pass "self" as the argument:
#
#  ChildWindow.new.show_glade(self)
#
#  This line would open a new ChildWindow window that always appears on top
#  of the parent (self) window, and freezes the parent window until it closes.
#


class ChildWindowDemo 

  include GladeGUI

  def buttonOpenModeless__clicked(*argv)
    ModelessWindow.new.show_glade(self) # no parent given so window is modeless
  end

# This modal window has its "modal" property set to true in glade.
# I pass a reference to "self" in the show method, setting the parent to this window,
# making it always on top.  Its a good idea to have modal windows always on top
# because the parent is frozen, so the next action must be in the modal window.

  def buttonOpenModal__clicked(*argv)
    ModalWindow.new.show_glade(self)  # self = parent, so always on top of parent
  end

  def buttonCancel__clicked(*argv)
    @builder["window1"].destroy
  end

end



