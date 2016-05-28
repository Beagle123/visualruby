
class MyClass #(change name)
 
	attr_accessor :ftv

	include GladeGUI

	def before_show()
		@ftv = ProjectTree.new()
		@builder["scrolledwindow1"].add(@ftv)  #needs show_all
		@builder["scrolledwindow1"].show_all
	end	

end

