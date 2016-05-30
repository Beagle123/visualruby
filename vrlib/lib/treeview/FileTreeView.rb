
module VR


  class FileTreeView < VR::TreeView # :nodoc:
  
  	include GladeGUI
  
  	attr_accessor :root, :glob, :test_block
  
  	def initialize(root = Dir.pwd, icon_path = nil, glob = "*")
      @root = root
      @glob = glob
      super(:file => {:pix => Gdk::Pixbuf, :file_name => String}, :empty => TrueClass, :path => String, :modified_date => VR::DateCol, :sort_on => String)
      col_visible( :path => false, :modified_date => false, :sort_on => false, :empty => false)
      self.headers_visible = false
      @icons = File.directory?(icon_path) ? VR::IconHash.new(icon_path) : nil
      parse_signals()
      model.set_sort_column_id(id(:sort_on), :ascending )
			self.set_enable_search(false)
      refresh
    end	

    # flags:  :root => root path, :open_folders => array of paths to open
  	def refresh(flags={}) 
			@root = flags[:root] if flags[:root]
			open_folders = flags[:open_folders] ? flags[:open_folders] : get_open_folders()
  		model.clear
			root_iter = add_file(@root, nil)
  		fill_folder(root_iter)
			expand_row(root_iter.path,false)
  		open_folders(open_folders)
    end
  
  	def fill_folder(parent_iter)
  		model.remove(parent_iter.first_child)   #remove dummy record
  	  files = Dir.glob(File.join(parent_iter[id(:path)],@glob))
  		files = files.select &@test_block if @test_block
  		files.each do |fn|
   			add_file(fn, parent_iter)
    	end	
  	end
  
  	def self__row_expanded(view, iter, path)
  		iter = model.get_iter(path)  #bug fix
     	fill_folder(iter) if iter[id(:empty)]
  		expand_row(iter.path, false)
  	end

		def expand_or_collapse_folder()
  		return unless row = selected_rows.first
  		if row_expanded?(row.path)
  			collapse_row(row.path)
  		else
  			self__row_expanded(self, row, row.path) 
  		end
		end

#  	def self__cursor_changed(*a)
#  		return unless row = selected_rows.first and @clickable_folders
#  		if row_expanded?(row.path)
#  			collapse_row(row.path)
#  		else
#  			self__row_expanded(self, row, row.path) 
#  		end
#  	end
  
  	def get_open_folders()
  		expanded = []
  		map_expanded_rows {|view, path| expanded << model.get_iter(path)[id(:path)] }
  		return expanded
  	end
  
  	def open_folders(folder_paths)
  		model.each do |model, path, iter| 
  			if folder_paths.include?(iter[id(:path)]) 	
  				expand_row(path, false) 
  			end
  		end
  	end	
  
  	def add_file(filename, parent)
      fn = filename.gsub("\\", "/")
      parent[id(:empty)] = false unless parent.nil?
      child = add_row(parent)
      child[:pix] = @icons.get_icon(File.directory?(fn) ? "x.folder" : fn) 	if @icons
      child[:file_name] = File.basename(fn)
      child[:path] = fn
      if File.directory?(fn)
      child[:sort_on] = "0" + child[:file_name]
      child[:empty] = true
      add_row(child) # dummy record so expander appears	
      else
      child[id(:sort_on)] = "1" + child[id(:file_name)]			
        end
  		return child
  	end
  
  	def set_show_expanders(expand)
  		self.show_expanders = expand
  		self.level_indentation  = expand ? 0 : 12
  	end
  
  	def folder?(iter) iter[id(:sort_on)][0,1] == "0" end
  
  	def file_name(iter) iter ? iter[id(:path)] : nil end
  
  	def get_selected_file_name() 
  		selection.selected ? selection.selected[id(:file_name)] : nil
  	end
  
  	def get_selected_path() (selection.selected ? selection.selected[id(:path)] : nil) end
  
  	def delete_selected()	self.model.remove(selection.selected) if selection.selected end
  
  end	
  
  
  

end


