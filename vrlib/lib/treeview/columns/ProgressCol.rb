
#  ==The VR Module hold all the classes of the vrlib gem.  The most useful APIs are:
#  
#  ===GladeGUI -- loads glade form 
#  ===VR::ListView -- makes Gtk::TreeView easy!


module VR

#  This class is simply a wrapper for an Integer.  It signals VR::Listview's
#  and VR::Treeviews constructor to make this column a progressbar using
#  VR::CellRendererProgress.  For example, whwn you create a VR::ListView,
#  you can pass VR::Progress as a column type:
#  
#   @view = VR::ListView.new(String, VR::Progress, Gdk::Pixbif)
#  
#  This makes model_col #1 a progress bar.  When you set the value of the column,
#  provide an integer value from 0 to 100:
#  
#  @view.add_row("Hello World", 65, @pixbuf)
#  
#  

  class ProgressCol < Integer 
  end

end
