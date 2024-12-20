module VR

  class TreeViewColumn < Gtk::TreeViewColumn # :nodoc:

    def initialize(view, sym) 
        super()
        self.title = sym.to_s.gsub("_", " ").split(' ').map {|w| w.capitalize }.join(' ') # My Title
        @view = view
        self.resizable = true
 #       self.visible = true
    end
 
    def add_renderer(model_col, sym, type)
        r = nil
        a = [model_col, self, @view, sym]
        if type == GdkPixbuf::Pixbuf # ok to use gtk
          r = Gtk::CellRendererPixbuf.new
          self.pack_start( r, false )
          self.add_attribute( r, :pixbuf,  model_col) 
        elsif type == TrueClass
          r = VR::Col::Ren::CellRendererToggle.new(*a)
          self.pack_start( r, false )
          self.add_attribute( r, :active,  model_col)
        elsif type == VR::Col::SpinCol #or type == Gtk::Adjustment 
          r = VR::Col::Ren::CellRendererSpin.new(*a)
          self.pack_start( r, false )
          self.add_attribute( r, :adjustment,  model_col)
          self.set_cell_data_func(r) do |col, rend, model, iter|
            fmt = "%.#{rend.digits}f"
            rend.text = fmt % iter[rend.model_col].value.to_s     
          end  
        elsif type == VR::Col::ComboCol 
          r = VR::Col::Ren::CellRendererCombo.new(*a)
          self.pack_start( r, false )
          self.set_cell_data_func(r) do |col, rend, model, iter|
            iter = model.get_iter(iter.path)
        #    display_val = iter[rend.model_col].selected.to_s 
            display_val = iter[@view.id(sym)].selected.to_s 
            rend.text = display_val #= iter[ren.model_col].selected.to_s
          end 
        elsif type == VR::Col::ProgressCol 
          r = Gtk::CellRendererProgress.new()
          self.pack_start( r, false )
          self.add_attribute( r, :value,  model_col)
        elsif type == DateTime 
          r = VR::Col::Ren::CellRendererDate.new(*a)
          self.pack_start( r, false )
          self.set_cell_data_func(r) do |col, ren, model, iter|
            ren.text = iter[ren.model_col].strftime(ren.date_format).to_s
          end
        elsif type == String or type == Float or type == Integer   
          r = VR::Col::Ren::CellRendererText.new(*a)
          self.pack_start( r, false )
          self.add_attribute( r, :text,  model_col)
        else #user defined object
          r = VR::Col::Ren::CellRendererObject.new(*a)
          self.pack_start( r, false )
          self.set_cell_data_func(r) do |col, ren, model, iter|
            obj = iter[@view.id(ren.model_sym)]
            obj.each_cell(col, ren, model, iter)
          end
        end
      return r
    end

    def width=(w) #pixels
      self.sizing = :fixed
      self.fixed_width = w
    end
     
    def sort_on(sym)
      self.sort_column_id = id(sym)
      self.clickable = id(sym).to_b
    end

    def sortable=(bool)
      self.sort_column_id = bool ? @view.id(@view.vr_cols.key(self)) : -1
    end

    def id
      @view.id(col_symbol)
    end

    def col_symbol
      @view.vr_cols.key(self)
    end

  end

end

