
class VR::Table < Gtk::Table

	attr_reader :current_row

	def initialize()
		super(0,0)
		@rows = []
		@current_row = 0

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
	#	n_rows = @current_row
puts "Spacing: " + get_row_spacing(@current_row).to_s
		return new_row
	end

end

