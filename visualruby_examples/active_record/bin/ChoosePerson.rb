
class ChoosePerson < VR::ListView

	include GladeGUI

	def initialize()
		super(:person => Person)  # Person class
	end

	def before_show()
		@builder["scrolledwindow1"].add(self)
		Person.all.each do |p|
			row = add_row(:person => p)
		end
	end

end
