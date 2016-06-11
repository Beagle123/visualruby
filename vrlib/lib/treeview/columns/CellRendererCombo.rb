module VR

#  This class is a helper to VR::ListView and VR::TreeView.  When
#  colums are created, this class is used as the renderer because
#  it adds functionality to the Gtk Renderer.
#  
#  When you call ListView#render(model_col) an instance of this class
#  will be returned.  It is a subclass of
#  
#  {Gtk::CellRendererCombo}[http://ruby-gnome2.sourceforge.jp/hiki.cgi?Gtk%3A%3ACellRendererCombo]
#  
#  So it has all the functionality of its parent, plus the methods listed here.
#  


  class CellRendererCombo < Gtk::CellRendererCombo
  
    attr_accessor :edited_callback, :validate_block 
    attr_reader :model_col, :column, :model_sym
  
    def initialize(model_col, column, view, model_sym) # :nodoc:
      super()
      @model_col = model_col
      @column = column
      @view = view
      @model_sym = model_sym
      @view.model.set_sort_func(@model_col) { |m,x,y| x[@model_col].selected <=> y[@model_col].selected }
      @validate_block = Proc.new { |text, model_sym, row, view | true } 
      self.editable = true
      self.has_entry = false
      @edited_callback = nil
      self.signal_connect('edited') do |ren, path, text| # iter for
        iter = @view.model.get_iter(path)
        if @validate_block.call(text, @model_sym, @view.vr_row(iter), @view)
          iter[@model_col].selected = text 
          @edited_callback.call(@model_sym, @view.vr_row(iter)) if @edited_callback
        end  
      end
    end

#  This sets the renderer's "editable" property to true, and makes it save
#  the edited value to the model.  When a user edits a row in the ListView
#  the value isn't automatically saved by Gtk.  This method groups both actions
#  together, so setting edit_save=true, allows both editing and saving of
#  the field.  
#  
#  Also, you can use VR::ListView and VR::TreeView's convenience methods to
#  envoke call this method:
#  
#   NAME = 0
#   ADDR = 1
#   @view.set_attr([NAME, ADDR], :edit_save => true)  #sets model_col = 0, 1 
#   @view.set_edit_save( 0 => true, 1 => false)
#  
#  is_editable = boolean
#  
 
    def set_model(vr_combo) # :nodoc:
      self.model = Gtk::ListStore.new(String)
      vr_combo.selections.each { |s| r = self.model.append ; r[0] = s }
      self.text_column = 0
    end
  
  end

end
