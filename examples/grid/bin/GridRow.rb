
class GridRow < Hash

	def initialize(parent)
		@parent = parent		
	end

	def []= (sym, widget)
		col_num = @parent.column_number(sym)
		@parent.attach(widget, col_num, @parent.current_row, 1, 1) 
		widget.show 
		super
	end

end
