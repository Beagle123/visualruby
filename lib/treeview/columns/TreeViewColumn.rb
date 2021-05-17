module VR::Col 

  class TreeViewColumn < Gtk::TreeViewColumn # :nodoc:
  
    def initialize(view, model_col, sym, type)
        super()
        self.title = sym.to_s.gsub("_", " ").split(' ').map {|w| w.capitalize }.join(' ') # My Title
        @view = view
        self.resizable = true
        cols = (type.is_a? Hash) ? type : {sym => type}
        cols.each_pair do |symb, type|
          r = nil
          a = [model_col, self, @view, symb]
          if type == GdkPixbuf::Pixbuf # ok to use gtk
            r = Gtk::CellRendererPixbuf.new #(*a)
            self.pack_start( r, false )
            self.add_attribute( r, :pixbuf,  model_col)
          elsif type == TrueClass
            r = VR::Col::Ren::CellRendererToggle.new(*a)
#            r = Gtk::CellRendererToggle.new()
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
#puts display_val
              rend.text = display_val #= iter[ren.model_col].selected.to_s
            end 
          elsif type == VR::Col::ProgressCol 
#            r = VR::Col::Ren::CellRendererProgress.new(*a)
            r = Gtk::CellRendererProgress.new()
            self.pack_start( r, false )
            self.add_attribute( r, :value,  model_col)
          elsif type == DateTime 
            r = VR::Col::Ren::CellRendererDate.new(*a)
            self.pack_start( r, false )
            self.set_cell_data_func(r) do |col, ren, model, iter|
#iter = model.get_iter(iter.path)
#puts "DateTime:" + iter[ren.model_col].class.name + ":" + iter[ren.model_col].to_s
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
              ren.render_object(iter)
            end
          end
          model_col = model_col + 1
          view.vr_renderer[sym] = r
        end
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

