module VR


  class ListView < Gtk::TreeView
  

#     include GladeGUI
    include ViewCommon

#     def before_show
#       @builder[:scrolledwindow1].add self
#       self.visible = true
#     end

# The new() constructor takes a Hash that defines the columns as its only argument.  The Hash defines
# symbols as the keys to give an ID to each column.  The Hash also defines the type (class) of the column.
# A simple constructor looks like this:
# @example
#  @view = VR::ListView.new(:name => String, :date => DateTime)
#
# You can create columns with any type of data including your own classes, and classes subclassed
# from ActiveRecordBase.  The common types that are included by default are:
#
# * String - Displays and edits as a String.
# * Integer - Displays numadd_activeber, edits like a String.
# * FixNum - ditto
# * Integer - ditto
# * Float - ditto
# * DateTime - Displays in a default date format(editable), edits like a String
# * TrueClass - Displays as a GtkCheckButton, click checkbox to edit
# * GdkPixbuf - Just an Image, uneditable
# * VR::Col::CalendarCol - Displays in a default date format(editable), calendar window to edit.
# * VR::Col::SpinCol - Displays as a number with default number of digits, edits like a GtkSpinButton
# * VR::Col::ComboCol - Displays String, edits like a GtkComboBoxEntry
# * VR::Col::ProgressCol - Displays a GtkProgressBar, uneditable
# * VR::Col::BlobCol - For long strings.  Displays first 20 characters in view, edits with simple text editor.
#
# You can also add your own user-defined column types.  See: {Adding Your Own Objects to ListView}[link:/site/ListView%20Tutorial.html#objects].
#

#     def initialize(cls)
#       super()
#       if cls.respond_to?(:column_names)
#         hash = {}
#         cls.column_names.each { |key| hash[key.to_sym] = String }
#         cols = hash
#       else
#         hash = flatten_hash(cls)
#         cols = cls
#       end
#       vals = hash.values
#       self.model = Gtk::ListStore.new(*vals)
#       load_columns(cols)
#       add_active_record_rows(cls) if cls.respond_to?(:column_names)    
#     end


    def add_active_record_rows(ar) # :nodoc:
      fields = ar.column_names.map { |x| x.to_sym }
      matches = fields & @column_keys #intersection
      ar.each do |obj|
        row = add_row()
        matches.each do |f|
#          begin  
            row[f] = obj[f] unless obj[f].nil?
#          rescue
#            row[f] = obj[f].to_s
#          end
        end          
      end
      self.visible = true
    end


    def []( row )  # :nodoc:
      model.get_iter(Gtk::TreePath.new("#{row}"))
    end
  
    def []( row, col )  # :nodoc:
      model.get_iter(Gtk::TreePath.new("#{row}"))[col]
    end

# This method will select a given row number.  The row will be hilighted, and the
# GtkSelection object will point to that row.  It uses the GtkTreeView#set_cursor
# method to move the cursor to the specified row.
#
#- row_number:  Integer (FixNum)
#

    def select_row(row_number = 0)
      set_cursor(Gtk::TreePath.new(row_number), nil, false)
    end  

#This will add a row to the data model, and fill-in the values from a Hash.
#This example would add a row to the model and set the name and email fields:
#
# @view.add_row(:name => "Chester", :email => "chester@chester.com")
#
#
#- hash: A ruby Hash object with pairs of column IDs (symbols) and values.

    def add_row(hash = {})
      row = vr_row(model.append)
      hash.each_pair { |key, val| row[key] = val }
      return row
    end
  
  end

 end
