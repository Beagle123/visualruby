
class VR::Table < Gtk::Grid

	attr_reader :current_row

	def initialize()
		@rows = []
		@current_row = 0
		super
	end

	def cursor
		@rows[current_row]
	end

	def clear
		@rows = []
	end

	def column_number(sym)
  	i = @rows[0].keys.index(sym)
  	return i.nil? ? @rows[0].keys.length : i 
	end
	

	def add_row()
		@rows << new_row = TableRow.new(self)
		@current_row = @rows.length - 1
		return new_row
	end

end

