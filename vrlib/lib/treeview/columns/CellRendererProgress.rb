module VR

  class CellRendererProgress < Gtk::CellRendererProgress # :nodoc:
  
  	attr_reader :model_col, :column, :model_sym
  
  	def initialize(model_col, column, view, model_sym)
  		super()
  		@model_col = model_col
			@model_sym = model_sym
  		@column = column
  		@view = view
			
  	end
  
  end

end
