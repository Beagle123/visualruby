module VR::Col::Ren

#  This class is a helper to VR::ListView and VR::TreeView.  When
#  colums are created, this class is used as the renderer because
#  it adds functionality to the Gtk Renderer.
#  
#  When you call ListView#render(model_col) an instance of this class
#  will be returned.  It is a subclass of
#  
#  {Gtk::CellRendererText}[http://ruby-gnome2.sourceforge.jp/hiki.cgi?Gtk%3A%3ACellRendererText]
#  
#  So it has all the functionality of its parent, plus the methods listed here.

  class CellRendererText < Gtk::CellRendererText
  
    attr_accessor :validate_block, :edited_callback
    attr_reader :model_col, :column, :model_sym

    def initialize(model_col, column, view, model_sym) # :nodoc:
      super()
      @column = column
      @model_sym = model_sym
      @model_col = model_col
      @view = view
      @validate_block = Proc.new { |text, model_sym, row, view| true }
      @edited_callback = nil
      self.signal_connect('edited') do |ren, path, text|
        next unless iter = @view.model.get_iter(path)
        if @validate_block.call(text, @model_sym, @view.vr_row(iter), @view)
          iter[@model_col] = (iter[@model_col].is_a? String) ? text : text.to_f
          @edited_callback.call(@model_sym, @view.vr_row(iter)) if @edited_callback
        end
      end 
    end
  
  end

end
