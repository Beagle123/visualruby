
	
module VR 

class DateCol
	
	attr_accessor :date

	def initialize(date, format = "%Y-%m-%d")
		set_date(date, format)
	end

	def set_date(date, format = "%Y-%m-%d")
		@date = date
#		gsub!(self, @date.strftime(format))
	end

end

end
