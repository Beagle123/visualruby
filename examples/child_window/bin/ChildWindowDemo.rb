 
##
#  This is a "main" GUI class for a program.  It allows you
#  to open modal and non-modal windows.  
#
#  Modal windows are
#  windows that appear on top of the main program window and
#  halt the main window until they are closed.  They're good for
#  dialogs etc.  
#
#  Normal non-modal child windows operate concurrently with the main
#  window and each other.  You can open many child windows, and they 
#  will all function at the same time.  For example, they're useful if you're
#  opening several documents at the same time.
#  
#  To open a modal window, just call the show() method with the parent
#  as the aregument.  Almost always, you will be calling the show method
#  from within the parent window so you would pass "self" as the argument:
#
#  ChildWindow.new.show(self)
#
#  This line would open a new ChildWindow window that always appears on top
#  of the parent (self) window, and freezes the parent window until it closes.
#
#  TO open a non-modal window, just call show() with no argument

class ChildWindowDemo #(change name)

	include GladeGUI

	def buttonOpenChild__clicked(*argv)
		win = MyChildClass.new("Child Non-Modal Window", "You can open as many of these as you want")
		win.show() #normal child window
	end

	def buttonOpenModal__clicked(*argv)
		win = MyChildClass.new("Modal Window", "Everything freezes until you close me!.\nI will always appear on top of main window.")
		win.show(self)  # modal window that appears always on top of this window
	end

	def buttonCancel__clicked(*argv)
		@builder["window1"].destroy
	end

end



