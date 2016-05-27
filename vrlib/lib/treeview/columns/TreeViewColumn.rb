module VR 

  class TreeViewColumn < Gtk::TreeViewColumn
  
  	def initialize(view, model_col, sym, type)
  			super()
				self.title = sym.to_s.gsub("_", " ").split(' ').map {|w| w.capitalize }.join(' ') # My Title
  			@view = view
  			self.resizable = true
				cols = (type.is_a? Hash) ? type : {sym => type}
  			cols.each_pair do |symb, type|
  				a = [model_col, self, @view, symb]
  				if type == Gdk::Pixbuf
  					ren = VR::CellRendererPixbuf.new(*a)
#  					ren = Gtk::CellRendererPixbuf.new #(*a)
  					self.pack_start( ren, false )
  					self.add_attribute( ren, :pixbuf,  model_col)
    			elsif type == TrueClass
  					ren = VR::CellRendererToggle.new(*a)
  					self.pack_start( ren, false )
  					self.add_attribute( ren, :active,  model_col)
    			elsif type == VR::SpinCol or type == Gtk::Adjustment 
  					ren = VR::CellRendererSpin.new(*a)
  					self.pack_start( ren, false )
  					self.add_attribute( ren, :adjustment,  model_col)
  					self.set_cell_data_func(ren) do |col, ren, model, iter|
  						fmt = "%.#{ren.digits}f"
#puts "Spin:" + iter[ren.model_col].class.name + ":" + iter[ren.model_col].to_s + ren.class.name.to_s
#alert( col.class.name + renderer.class.name + model.class.name + iter.class.name + iter[renderer.model_col].value.to_s )
							str = fmt % iter[ren.model_col].value
  						ren.text = str		
  					end  
    			elsif type == VR::ComboCol 
  					r = VR::CellRendererCombo.new(*a)
  					self.pack_start( r, false )
  					self.set_cell_data_func(r) do |col, ren, model, iter|
#iter = model.get_iter(iter.path)
#puts "Combo:" + iter[ren.model_col].class.name + ":" + iter[ren.model_col].to_s
  						ren.text = iter[ren.model_col].selected.to_s
  					end 
    			elsif type == VR::ProgressCol 
  					r = VR::CellRendererProgress.new(*a)
  					self.pack_start( r, false )
  					self.add_attribute( r, :value,  model_col)
    			elsif type == DateTime 
  					r = VR::CellRendererDate.new(*a)
  					self.pack_start( r, false )
  					self.set_cell_data_func(r) do |col, ren, model, iter|
#iter = model.get_iter(iter.path)
#puts "DateTime:" + iter[ren.model_col].class.name + ":" + iter[ren.model_col].to_s
  						ren.text = iter[ren.model_col].strftime(ren.date_format)
  					end
    			elsif type == String or type == Float or type == Integer or type == Fixnum  
  					r = VR::CellRendererText.new(*a)
  					self.pack_start( r, false )
  					self.add_attribute( r, :text,  model_col)
					else #user defined object
  					r = VR::CellRendererObject.new(*a)
  					self.pack_start( r, false )
  					self.set_cell_data_func(r) do |col, ren, model, iter|
							ren.render_object(iter)
  					end
      		end
  				model_col = model_col + 1
  			end
  	end
  
  	def width=(w) #pixels
    	self.sizing = :fixed
    	self.fixed_width = w
  	end
 
		def sortable=(is_sortable) 
			self.sort_column_id = cell_renderers[0].model_col
     self.clickable = is_sortable 
		end

  end

end

