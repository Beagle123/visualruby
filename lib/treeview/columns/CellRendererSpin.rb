module VR::Col::Ren

#  This class is a helper to VR::ListView and VR::TreeView.  When
#  colums are created, this class is used as the renderer because
#  it adds functionality to the Gtk Renderer.
#  
#  When you call ListView#render(column_id) an instance of this class
#  will be returned.  It is a subclass of
#  
#  GtkCellRendererSpin
#  
#  So it has all the functionality of its parent, plus the methods listed here.

  class CellRendererSpin < Gtk::CellRendererSpin
  
    attr_reader :model_col, :column, :model_sym
    attr_accessor :edited_callback  

    def initialize(model_col, column, view, model_sym) # :nodoc:
      super()
      @model_col = model_col
      @model_sym = model_sym
      @column = column
      @view = view
      self.editable = true
      @view.model.set_sort_func(@model_col) { |m,x,y| x[@model_col].value <=> y[@model_col].value }
      @edited_callback = nil
      self.signal_connect('edited') do |ren, path, text|
        next unless iter = @view.model.get_iter(path)
        iter[@model_col].value = text.to_f if (iter)
        @edited_callback.call(@model_sym, @view.vr_row(iter)) if @edited_callback
      end
    end
  
  end

end
