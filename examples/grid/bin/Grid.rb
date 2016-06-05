
class VR::Grid < Gtk::Grid

	attr_accessor :current_row, :event_box

	def initialize()
		super
		@event_box = Gtk::EventBox.new()
		@event_box.visible = true
		@event_box.above_child = true
		@rows = []
		@current_row = 0
		@event_box.add(self)
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
		@rows << new_row = GridRow.new(self)
		@current_row = @rows.length - 1
		return new_row
	end

end

