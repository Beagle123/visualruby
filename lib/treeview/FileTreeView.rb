
module VR

  class FileTreeView < VR::TreeView
  
    include GladeGUI
  
    attr_accessor :root, :glob

    # A Code block that further excludes files and folders included in the tree. If this block returns false 
    # for the entry, it will be excluded. If it returns true, it will be included...  
    attr_accessor :validate_block

    # FileTreeView creates a TreeView of files with folders and icons.  
    # Often you should subclass this class for a particular use.
    # @param [String] root Root folder of the tree  
    # @param [String] icon_path Path to a folder where icons are stored.  See VR::IconHash
    # @param [String] glob Glob designating the files to be included.  Google: "ruby glob" for more.
    # @param [Proc] validate_block Block that limits files and folders to include. When block returns true file is includud. (false = excluded)  
    def initialize(root = Dir.pwd, icon_path = nil, glob = "*", validate_block = nil)
      @root = File.expand_path(root)
      @glob = glob
      @validate_block = validate_block
      super(:file => {:pix => Gdk::Pixbuf, :file_name => String}, :empty => TrueClass, 
            :path => String, :sort_on => String)
      col_visible( :path => false, :sort_on => false, :empty => false)
      self.headers_visible = false
      @icons = File.directory?(icon_path) ? IconHash.new(icon_path) : nil
      parse_signals()  #fix this!  Subclasses may call twice!
      model.set_sort_column_id(id(:sort_on), :ascending )
      self.set_enable_search(false)
      refresh
      self.visible = true # necessary!
    end  

    # Refresh the file tree, optionally with a new root folder, and optionally opening an array of folders.
    # @param [Hash] flags You can change the root and/or  open an array of folders.
    # @option flags [String] :root Path to root folder to open
    # @option flags [Array] :open_folders A list of folders to open, possibly from #get_open_folders.
    #    Default: the currently open folders, so the tree doesn't collapse when refreshed. 
    def refresh(flags={}) 
      @root = flags[:root] if flags[:root]
      open_folders = flags[:open_folders] ? flags[:open_folders] : get_open_folders()
      model.clear
      @root_iter = add_file(@root, nil)
      open_folders([@root_iter[:path]])
      open_folders(open_folders)
    end

    # reads a folder from the disk and expands it.
    private def fill_folder(parent_iter)
      model.remove(parent_iter.first_child)   #remove dummy record
      files = Dir.glob(File.join(parent_iter[id(:path)], @glob))
      files = files.select &@validate_block if @validate_block
      files.each do |fn|
         add_file(fn, parent_iter)
      end  
    end

    #Ignore this, it is called when a folder is clicked, and expands the folder.
    def self__row_expanded(view, iter, path)
      iter = model.get_iter(path)  #bug fix
      fill_folder(iter) if iter[id(:empty)]
      expand_row(iter.path, false)
    end

    # Expands or collapses the currently selected row
    def expand_or_collapse_folder()
      return unless row = selected_rows.first
      if row_expanded?(row.path)
        collapse_row(row.path)
      else
        self__row_expanded(self, row, row.path) 
      end
    end

    # returns an array of open folders.  The array of folders can be saved, and then you can
    # pass the array to #open_folders to restore the state of the file tree.
    # @return [Array] Returns array of strings with the full expanded paths of the open folders.
    def get_open_folders()
      expanded = []
      map_expanded_rows {|view, path| expanded << model.get_iter(path)[id(:path)] }
      return expanded
    end

    # Opens a list of folders.  
    # @param [Array] folder_paths Array of Strings of folder names to expand, possibly from the #get_open_folders method.
    def open_folders(folder_paths)
      model.each do |model, path, iter| 
        if folder_paths.include?(iter[id(:path)])
          self__row_expanded(self, iter, path)    
        end
      end
    end  

    # Adds a file to the tree under a given parent iter. 
    # @param [String] filename Full path to file to add.
    def add_file(filename, parent = @root_iter)
      my_path = File.dirname(filename)
      model.each do |model, path, iter|
        return if iter[id(:path)] == filename # duplicate
        parent = iter if iter[id(:path)] == my_path
      end
      fn = filename.gsub("\\", "/")
      parent[id(:empty)] = false unless parent.nil?
      child = add_row(parent)
      child[:pix] = @icons.get_icon(File.directory?(fn) ? "x.folder" : fn)   if @icons
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

    # Sets whether or not the little arrow expanders appear net to the folders.
    # @param [Boolean] expand Whether or not to show the expanders next to the folders.
    def set_show_expanders(expand = true)
      self.show_expanders = expand
      self.level_indentation  = expand ? 0 : 12
    end
  
    # Returns the full filename with path of the selected file.
    # @return [String, nil]  Full file path to selected file.
    def get_selected_path() 
      selection.selected ? selection.selected[id(:path)] : nil 
    end

    class IconHash < Hash # :nodoc:
    
      def initialize(path)
        Dir.glob(path + "/*.png").each do |f|
          ext = File.basename(f, ".png")
          self[ext] = Gdk::Pixbuf.new(f)
        end
      end
    
      def get_icon(file_name)
        ext = File.extname(file_name).gsub(".", "")
        self.has_key?(ext) ? self[ext] : self["unknown"] 
      end
    end

  
  end  
  

  

end


