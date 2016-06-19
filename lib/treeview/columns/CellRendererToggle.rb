module VR::Col::Ren

#
#  This renderer has a slightly different validate_block than the others.  Its validate_block will be called with three
#  parameters:
#  
#   @view.renderer(:name).validate_block = Proc.new { | model_sym, row, view |
#     (row[:name].length < 3)
#   }
#  
#  Also, you can use the VR::Col::Ren::CellRendererToggle#edited= method to allow editing.
#

  class CellRendererToggle < Gtk::CellRendererToggle
  
    attr_accessor :validate_block, :edited_callback 
    attr_reader :model_col, :column, :model_sym

    def initialize(model_col, column, view, model_sym)
      super()
      @model_col = model_col
      @model_sym = model_sym
      @column = column
      @view = view
      @edited_callback = nil
      @validate_block = Proc.new { |model_sym, row, view | true }
      self.signal_connect('toggled') do |ren, path|
        @view.model.each { |mod, path, iter| iter[@model_col] = false } if self.radio?
        next unless iter = @view.model.get_iter(path)
        if @validate_block.call(@model_sym, @view.vr_row(iter), @view)
          iter[model_col] = !iter[model_col]
          @edited_callback.call(@model_col, iter) if @edited_callback
         end
      end
    end
  
    def editable=(is_editable)
      self.sensitive = is_editable
    end

    def set_editable(is_editable)
      self.sensitive = is_editable
    end
  
  end
 
end 
