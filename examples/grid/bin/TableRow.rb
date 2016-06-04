
class TableRow < Hash

	def initialize(parent)
		@parent = parent		
	end

	def []= (sym, widget)
		col_num = @parent.column_number(sym)
puts sym.to_s + col_num.to_s + "-" + @parent.current_row.to_s
		@parent.attach(widget, col_num, col_num+1, @parent.current_row, 
				@parent.current_row+1, :fill, :fill)
		widget.show 
		super
	end

end
