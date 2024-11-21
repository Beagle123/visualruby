
class DragDropDemo

  include GladeGUI

  def before_show()
    @window1 = "Drag and Drop Demo"
    @textview1 = "I'm a widget named textview1.\n\nTry dragging a file or the button onto me."
    @view = VR::FileTreeView.new(Dir.pwd,"./img")
    @view.refresh()
    @view.expand_row(@view.model.iter_first.path, false)
    @builder["scrolledwindow1"].add(@view)
    @view.visible = true
    set_drag_drop("button1" => "textview1", @view => "textview1", "textview1" => "button1")
  end  


#    This executes when button1 receives a widget dropped on it.  When the button1 widget
#    receives a drag_drop signal, an instance variable named dragged_widget is set automatically set
#    by visualruby containing a reference to the dragged widget:

  def button1__drag_drop(widget, *args)
    but1 = @builder["button1"]
    if but1.dragged_widget.is_a?(Gtk::TextView)
      but1.label = but1.dragged_widget.buffer.text.slice(0,15) 
    elsif but1.dragged_widget.is_a?(VR::FileTreeView)
      but1.label = @view.get_selected_path()
    end
  end

  def textview1__drag_drop(widget, context, *args)
    tv1 = @builder["textview1"]
    if tv1.dragged_widget == @view
      path = @view.get_selected_path()
      tv1.buffer.text = File.basename(path)
    elsif tv1.dragged_widget.is_a?(Gtk::Button)
      tv1.buffer.text = tv1.dragged_widget.label
    end
  end  

end




