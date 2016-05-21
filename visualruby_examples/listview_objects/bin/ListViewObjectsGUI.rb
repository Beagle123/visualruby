
#  This class just adds a GUI to the ListViewObjects class.

class ListViewObjectsGUI < ListViewObjects

	include GladeGUI

	def before_show
		@builder["scrolledwindow1"].add(self)
		# edited_callback is a method that is called after a cell has been edited.  It is
		# used to do housekeeping after the value of the cell has changed. 
		renderer(:quote).edited_callback = method(:self__cursor_changed) 
	end

#  When the selection changes, the quote at the bottom of the page needs to be updated.
#  Then the quote matches the selected record.  Try it.

	def self__cursor_changed(*args)
		return unless row = selected_rows.first  # iter = selection.selected
		@builder["labelQuote"].label = row[:quote].text 
	end


end

