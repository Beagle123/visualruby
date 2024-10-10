module VR

#  This module holds all the methods that both VR::ListView
#  and VR::TreeView use.  All the methods listed here can be called from a
#  VR::ListView or a VR::TreeView.
#  
#  ==The col_<propery>, ren_<property>, col_attr, and ren_attr methods
#  
#  All of these methods do the same thing:  set the properties of your VR::ListView.
#  
#  The way to configure a VR::ListView or VR::TreeView is to set the properties
#  of its columns (and renderers).  For example,
#  setting the "title" property of a column will set the title that appears at the top.
#  
#  The normal Gtk approach to setting properties of a GtkTreeViewColumn, (or renderer) is to set
#  them individually:
#  
#   col = Gtk::TreeViewColumn.new()
#   col.title = "My Title"
#  
#  This is slow, and tedious.  However, you can completely configure any VR::ListView or
#  VR::TreeView object with only a few lines of code using the above methods.  They can set many properties on many columns
#  at once.  
#  
#  The first thing to understand is that there are several ways to set properties.  In fact all
#  of these lines of code do the exact same thing:
#  
#   column(:name).title = "Person's Name"
#   col_title(:name => "Person's Name")
#   ren_title(:name => "Person's Name")
#   col_attr(:name, :title => "Person's Name")
#   ren_attr(:name, :title => "Person's Name")
#  
#  All the above lines of code simply set the title of the :name column.  So why
#  is one method better than another?   Answer:  because you can set multiple
#  properties on multiple columns with one line of code.  For example, you can set all the titles
#  with this line:
#  
#   col_titles(:name => "Name", :email => "Address", :phone => "Phone Number")
#  
#  The col_<property> method is very good at setting <b>multiple columns</b>.
#  
#  Likewise, the VR::ListView#col_attr method is good at setting the same property on multiple columns:
#  
#   col_attr(:name, :email, :phone, :width => 200, :weight => 700) #bold
#  
#  Either way, you can set everything with one line of code.  Also, if you want to set
#  a propery for all the columns, simply omit any column IDs:
#  
#   col_width(200)
#   ren_background("yellow")
#   col_attr(:font => "Sans")
#   ren_attr(:visible => true)
#  
#  There are many, many possibilities of properties you can set using these methods.
#  You need to know the name of the property that you want to set from consulting
#  the docs for GtkTreeViewColumn and the docs for the column's renderer type (listed on the left of this webpage)
#  
#  Any of the properties of these classes can be set using the above methods.
#  
#  If you consult, GtkCellRendererText for example, you'll see that it has a "background" property.
#  Therefore you can use ren_background() to set the color of the background of that column.
#  
#  Method names like "col_title" are just one possibility of methods you can use.
#  You could call any of these as well:
#  
#   col_width
#   col_xalign  # (0.00 to 1.00, 1 = right justify)
#   col_weight  # (100 to 900)
#   col_background
#   col_foreground
#   col_font
#   col_markup
#   col_size
#   col_spacing
#  
#  You'll notice that some of the methods listed above don't look valid.  For example,
#  col_background doesn't seem to make sense because the GtkTreeViewColumn doesn't
#  have a <b>background</b> property.  The <b>background</b> property belongs to the
#  renderer, GtkCellRendererText.  But, the col_<attribute> method is programmed
#  to try to set the property on the column first, and if the column object doesn't
#  support the propery, it will look in the renderer.  If the renderer doesn't support it,
#  it DOES NOTHING.
#  
#  Likewise, the ren_<property> method will look first in the renderer for the property, then
#  the column.  The only difference between the ren_<property> and col_<propery> methods
#  is that the ren_<property> looks in the renderer object first.  These two methods
#  are almost interchangable.  In fact, I always just use the col_<propery> method
#  because it looks better.  The only time I have a problem is when the column and the renderer
#  have the same property (i.e. "visible" and "xalign").  Then, I simply substitute the ren_<property> method.
#  
#  ==Summary
#  
#  - To set the <b>same attribute value</b> on multiple columns use col_attr() or ren_attr()
#  - To set <b>different attribute values</b> on multiple columns, use col_<property> or ren_<property>
#  - The ren_<property> and col_<property> methods are almost interchangable.
#  - The ren_attr() and col_attr() methods are almost interchangable.
#  - To set the properties of <b>all</b> the columns, omit any column iDs
#  - Consult the documentation for GtkTreeViewColumn to learn about properties to set.
#  - Consult the Gtk docs for the renderer by locating the type on the left of this webpage.
#  
#  Some examples are:
#   ren_background(:name => "yellow", :email => black)  #renderer for :name bg = yellow
#   col_editable(false) #makes all columns un-editable
#   col_width(:name => 300, email => 200)
#   ren_xalign(:email => 1)  # right justify email 
#   ren_attr(:name, :email, :font => "Courier") 
#   ren_attr(:font => "Sans") # all columns now Sans font
#   col_attr(:name, :email, :visible => true)
#  

  module ViewCommon

    attr_accessor :vr_renderer, :column_keys, :vr_cols, :vr_id, :vr_column, :vr_renderer


    def initialize(cols)
      args = flatten_hash(cols).values
      super()
      @vr_column = {}
      @vr_renderer = {}
      @vr_id = {}
      @current_model_col = 0
      if self.is_a? VR::TreeView
        self.model = Gtk::TreeStore.new(*args)
      else
        self.model = Gtk::ListStore.new(*args)
      end
      cols.each_pair do |sym, type|
        add_column(sym, type)
      end
      turn_on_comboboxes()
      @column_keys = flatten_hash(cols).keys  # this is shakey
    end


    def add_column(sym, type)
      @vr_column[sym] = col = VR::TreeViewColumn.new(self, sym)
      self.append_column(col)
      if type.is_a? Hash
        type.each_pair do |s,t|
          add_renderer_to_col(col, s, t)
        end
      else
        add_renderer_to_col(col, sym, type)
      end
    end

    def add_renderer_to_col(col, sym, type)
      @vr_renderer[sym] = col.add_renderer(@current_model_col, sym, type)
      @vr_id[sym] = @current_model_col
      @current_model_col += 1
    end


  
#     def load_columns(cols) # :nodoc:
#       @vr_renderer = {}
#       @vr_cols = {}
#       model_col = 0
#       cols.each_pair do | sym, type|
#         col = VR::Col::TreeViewColumn.new(self, model_col, sym, type)
#         model_col = model_col + (type.class == Hash ? type.size : 1)
#         self.append_column(col)
#         @vr_cols[sym] = col
#       end
#       turn_on_comboboxes()
#       @column_keys = flatten_hash(cols).keys
#     end

    #shortcut to set_cell_data_func!
    def each_cell_method(col_symbol, block)
      @vr_column[col_symbol].set_cell_data_func(@vr_renderer[col_symbol]) do |col, rend, model, iter|
        block.call(col, rend, model, iter)
      end
    end
  
    def method_missing(meth, *args) # :nodoc:
      unless m = /^(ren_|col_)(.+)$/.match(meth.to_s)
        super
        return
      end     
      if args.first.is_a? Hash
        args.first.each_pair { |key, val| method(m[1] + "attr").call(key, m[2] => val) }
      else
        method(m[1] + "attr").call(m[2] => args.first) 
      end
    end

# Sets properties on renderers (and columns)  See VR::ViewCommon#col_attr for more.

    def ren_attr(*args)
      cols = args.select { |arg| !arg.is_a? Hash }
      return unless hash = args.detect { |arg| arg.is_a? Hash }
      cols = @column_keys if cols.empty?
      cols.each do |c|
        hash.each_pair do | key, val |
          if renderer(c).respond_to?(key.to_s + "=")  
             renderer(c).send(key.to_s + '=', val) 
          elsif column(c).respond_to?(key.to_s + "=")
            column(c).send(key.to_s + '=', val) 
          end 
        end
      end    
    end  

#  Sets properties on many columns at once.  It can be called with many columns and many attributes.
#  Also, if you don't specify any columns, it will set the properties on all of them.  There are
#  many ways to call this method, here are a few:
#  
#   @view.col_attr(:name, :date, background: "yellow", foreground: "black")
#   @view.col_attr(:background => "yellow", foreground => "black") #sets all columns
#   @view.col_attr(:name, :date, :editable => true) # both editable now
#   @view.col_attr(:editable => false) # turns off editing to all columns
#  
#  Also, if the column VR::TreeViewColumn object doesn't support the property, it will try to
#  set the property on the renderer instead.  In the above example, the col_attr() method tries to
#  set the "<b>background</b>" property of a VR:TreeViewColumn.  However, that object doesn't
#  support the "background" property, but the renderer for the column, VR::Col::Ren::CellRendererText does.
#  So it sets the renderer's property instead.  So, in this example this line of code would do exactly the same
#  thing:
#  
#   @view.ren_attr(:name, :date, :background => "yellow", foreground => "black")
#  
#  In the vast majority of cases, VR::ViewCommon#col_attr and VR::ViewCommon#ren_attr are interchangable.

  
#
#   From     gtk3/tree-view-column.rb
#     alias_method :add_attribute_raw, :add_attribute
#     def add_attribute(renderer, key, value)
#       key = key.to_s if key.is_a?(Symbol)
#       add_attribute_raw(renderer, key, value)
#     end
# 


    def col_attr(*args)
      cols = args.select { |arg| !arg.is_a? Hash }
      return unless hash = args.detect { |arg| arg.is_a? Hash }
      cols = @column_keys if cols.empty?
      cols.each do |c|
        hash.each_pair do | key, val |
          if column(c).respond_to?(key.to_s + "=")
            column(c).send(key.to_s + '=', val)
          elsif renderer(c).respond_to?(key.to_s + "=")  
            renderer(c).send(key.to_s + '=', val) 
          end 
        end
      end    
    end


#  Returns an array of rows that are selected in the VR::TreeView or VR::ListView.
#  If nothing is selected, it returns an empty array.  If you've configured your
#  listview to accept multiple selections, it will return all of them.  In single 
#  selection mode, it will return an array with one row.  These rows are
#  able to respond to column IDs.  They are the same types of rows as returned by
#  VR::ViewCommon#vr_row.
    
    def selected_rows()
      rows = []
      selection.each do |model, path, iter|
        rows << vr_row(iter) 
      end
      rows
    end  

    def delete_selected()
      refs = []
      selection.each do  |mod, path, iter|
        refs << Gtk::TreeRowReference.new(mod, path)
      end
      refs.each do |ref|
        model.remove(model.get_iter(ref.path))
      end   
    end
  
    def turn_on_comboboxes() # :nodoc:
      # detect if comboboxes are present:
      found = false
      self.each_renderer do |r|
        if r.is_a? VR::Col::Ren::CellRendererCombo
          found = true
          break
        end
      end  
      return unless found
      self.signal_connect("cursor_changed") do |view|
        next unless iter = view.selection.selected
        @vr_renderer.each do |sym, ren|
          ren.set_model iter[id(sym)] if ren.is_a? VR::Col::Ren::CellRendererCombo
        end
#        view.each_renderer do |r|
#          r.set_model( iter[r.model_col] ) if r.is_a? VR::Col::Ren::CellRendererCombo
#        end
      end    
    end

    def flatten_hash(hash) # :nodoc:
      h = {}
      hash.each do | k, v |
        if v.class == Hash
          v.each_pair { |key, val| h[key] = val }
        else
          h[k] = v
        end
      end 
       return h
    end

#  Enumerates each row in the model and returns an instance of GtkTreeIter.
#  However, the iters returned have been converted into a "row" using VR::ViewCommon#vr_row
#  so they will respond to colum IDs (symbols).  Like this:
#  
#   @view.each_row { |row| puts row[:name] }  # works!
#

    def each_row
      self.model.each do |mod, pth, itr|
        iter = model.get_iter(pth) #bug? 
        yield vr_row(iter) 
      end
    end

#  Converts a normal GtkTreeIter to use VR's column IDs.  You can use it like this:
#  
#   row = @view.vr_row(iter)   # iter is a Gtk::TreeIter
#   row[:name] = "Chester"  # works!


    def vr_row(iter)
      unless iter.respond_to?(:id)
        iter.extend(IterMethods)
        iter.column_keys = @column_keys
      end
      return iter
    end 

    def get_iter(path)
      vr_row(model.get_iter(path))
    end


#  Returns a VR::TreeViewColumn object for the column.  You can pass this method either
#  a column ID (symbol) or the column number.  Since, VR::TreeViewColumn is a subclass
#  of Gtk::TreeViewColumn, you should consult Gtk::TreeViewColumn's documentation to
#  see all the properties you can set on this object:
#  
#   @view.column(:name).title = "Person's Name"
#   @view.column(:ok).visible = false
#   @view.column(:name).class.name  # => VR:TreeViewColumn
#   
#  Even though the above statements are valid, its usually easier to use the col_<property>
#  methods instead.  See VR::ViewCommon for more.

  
    def column(id)
      @vr_id[id]
    end
    
    def each_renderer
      self.columns.each do |c| 
        c.cells.each do |r| 
          yield r 
        end
      end
    end

#Returns the renderer for a given column ID.
#
#In VR::ListView#new (and VR::TreeView#new) method, a data model (VR::ListStore or VR::TreeStore) is automatically contstructed.
#Then the class will automatically assign a renderer to show it on the screen.  These renderers
#simply convert a piece of data to something visual on the screen.  For example, a column in the model
#might contain a value "true," but the renderer converts it to a GtkCheckButton which shows a check-mark.
#The VR::ListView class will 
#automatically assign renderers to each column based on its type:
#
#String, Integer, Float => VR::Col::Ren::CellRendererText
#TrueClass => VR::Col::Ren::CellRendererToggle
#GdkPixbuf => VR::Col::Ren::CellRendererPixbuf
#DateTime => VR::Col::Ren::CellRendererDate
#VR::Col::CalendarCol, VR::Col::BlobCol => VR::Col::Ren::CellRendererObject
#VR::Col::SpinCol => VR::Col::Ren::CellRendererSpin
#VR::Col::ProgressCol => VR::Col::Ren::CellRendererProgress
#VR::Col::ComboCol => VR::Col::Ren::CellRendererCombo
#
#The renderer() method will return one of these renderers:
#
# ren = @view.renderer(:ok)
# puts ren.class.name  # VR::Col::Ren::CellRendererToggle  (:ok column is a TrueClass)
# puts @view.renderer(:name).class.name # =>  VR::Col::Ren::CellRendererText
#
#All the types of renderers are subclasses of Gtk renderers.  For example,  VR::Col::Ren::CellRendererText
#is a subclass of Gtk::CellRendererText.  So, you can use these objects just as you would use a 
#normal Gtk renderer:
# 
# @view.renderer(:name).width = 100
#
#This is perfectly valid even though there are better ways of setting these properties in visualruby.

    def renderer(sym)
      @vr_renderer[sym]
    end
 
#    def renderer(id)
#      each_renderer do |r| 
#        return r if r.model_col == id(id) 
#      end
#      return nil
#    end

#  Returns the number of the given column ID.  This is very useful when you're
#  working with Gtk's methods because they require column numbers (not Column IDs)
#  This method converts the column ID symbols from the VR::ListView#new constructor
#  to Integers:
#  
#   @view = VR::ListView.new(:name => String, :date => VR::Col::CalendarCol)
#   
#   Later in code...
#  
#   iter = get_iter(path)
#   col_num = id(:date)  # 1
#   iter[col_num]
#  
#  You won't need to use this when adding rows with VR::ListView#add_row, and
#  you also have the option of converting the whole iter to use column IDs (symbols)
#  using VR::ViewCommon#vr_row.

    def id(id)
#       if id.is_a Integer
#       elsif id is_a? Symbol
#       elsif
      return (id.is_a? Integer) ? id : @column_keys.index(id)
    end  

  end
end
