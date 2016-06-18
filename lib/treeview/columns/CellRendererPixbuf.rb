module VR

  class CellRendererPixbuf < Gtk::CellRendererPixbuf # :nodoc:
  
    attr_reader :model_col, :column, :model_sym
  
    def initialize(model_col, column, view, model_sym)
      super()
      @column = column
      @model_col = model_col
      @model_sym = model_sym
      @view = view
    end
  end

end
