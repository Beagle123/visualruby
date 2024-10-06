
module VR
#  
#  TreeView is almost identical to VR::ListView.  The only difference
#  is how rows are added, and that they use a different model class.
#  See VR::ListView for in-depth docs.  Also, see Gtk::TreeView for more.
#  
#  Also, most of the useful methods for VR::TreeView are found in VR::ViewCommon.
#  All the methods in VR::ViewCommon work on VR::TreeViews and VR::ListViews. 
#
  class TreeView < Gtk::TreeView
  
    include ViewCommon

#  See VR::ListView constructor. (exactly the same)

    def initialize(cols)
      super()
      args = *flatten_hash(cols).values
      self.model = Gtk::TreeStore.new(*flatten_hash(cols).values)
      load_columns(cols)
    end
#
#  Adds row to the model.  This will return a "row" type iter that responds
#  to column IDs (symbols).  You need to provide a parent row (iter).
#  See GtkTreeView#append for more.
#
#  The iter is a GtkTreeIter object for the parent or nil for the root of the tree.  The hash argument is a Hash of values to add:
# 
#  @view.add_row(iter, :name => "Chester", :email => "chester@chesterizer.com")
#
#  

     def add_row(parent, hash = {})
      row = vr_row(model.append(parent))
      hash.each_pair { |key, val| row[key] = val }
      return row
    end

  end

end
