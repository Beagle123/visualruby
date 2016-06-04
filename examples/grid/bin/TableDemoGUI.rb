
class TableDemoGUI

	include GladeGUI


	def before_show()
		@table = TableDemo.new()
		@builder[:scrolledwindow1].add(@table)
		@table.show
	end


end
