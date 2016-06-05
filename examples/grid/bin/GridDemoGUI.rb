
class GridDemoGUI

	include GladeGUI


	def before_show()
		@grid = GridDemo.new()
		@builder[:scrolledwindow1].add(@grid.event_box)
	end

	def self__button_press_event(*a)
		alert "Hello"
	end

end
