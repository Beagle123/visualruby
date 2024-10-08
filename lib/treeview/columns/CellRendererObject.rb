module VR::Col::Ren

#  This class is a helper to VR::ListView and VR::TreeView.  When
#  colums are created, this class is used as the renderer because
#  it adds functionality to the Gtk Renderer.
#  
#  When you call ListView#render(model_col) an instance of this class
#  will be returned.  It is a subclass of Gtk::CellRendererText
#  
#  So it has all the functionality of its parent, plus the methods listed here.

  class CellRendererObject < Gtk::CellRendererText
  
    attr_accessor :model_col, :column, :edited_callback, :visual_attributes_method, :model_sym

    def initialize(model_col, column, view, model_sym) # :nodoc:
      super()
      @model_col = model_col
      @model_sym = model_sym
      @view = view
      @column = column
      @edit = true
      @edited_callback = nil
      @visual_attributes_method = "visual_attributes"
      @view.model.set_sort_func(@model_col) { |m,x,y| x[@model_col] <=> y[@model_col] } 
      @show_block = Proc.new { |obj| obj.show_glade() if obj.respond_to? "show_glade" }
      @view.signal_connect("row_activated") do | view, path, col |
        next if !@edit or !col.eql? @column
        iter = @view.model.get_iter(path)
        obj = iter[@model_col]
        @show_block.call(obj)
        block = @edited_callback ? @edited_callback.call(@model_sym, @view.vr_row(iter)) : true 
        @view.signal_emit_stop("row_activated") if block  
      end
    end
  
    alias :set_editable :editable=  
    def editable=(e)
      @edit = e
    end
  
    def render_object(iter)
      obj = iter[@view.id(@model_col)]
      self.text = obj.respond_to?(:to_s) ?  obj.to_s : "Define to_s!"
      if obj.respond_to? @visual_attributes_method
        return unless attrib = obj.send(@visual_attributes_method)
        attrib.each_pair do | key, val |
          self.send( key.to_s + "=", val)
        end
      end
    end
 
  end

end
