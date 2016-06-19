
# ObjectInspector isn't meant to be called directly, #oinspect for API.
module VR::ObjectInspector
  # ObjectInspector isn't meant to be called directly, see #oinspect for API.
  class ObjectInspectorGUI
    
    include GladeGUI

    def initialize(obj=self)
      @obj = obj
      @obj_to_s = obj.to_s
      @meth_view = MethodsListView.new(@obj)
      @var_view = VariablesListView.new(@obj)
    end

    def before_show()
      @headline = "<big><big>#{@obj.class.name}  (ID:  #{@obj.__id__})</big></big>"
      @builder[:scrolledwindow1].add @meth_view
      @builder[:scrolledwindow2].add @var_view
      @builder[:paned1].position = 400
      @builder[:window1].show_all
    end  

    def var_view__row_activated(*args)
      row = @var_view.selected_rows.first
      oinspect row[:obj] 
    end

  end

end

# @param [Object] obj Any object that you want to display.
# @return none.
# Displays object on screen and halts the program.  Anywhere in your code you can halt 
# the execution, and display an object in a window like this:
#   alert anyobject
#
# Also, at any window, if you press the F8 key, the object inspector will run.  Try it.

# http://visualruby.net/img/object_inspector.jpg
#
def oinspect(obj=self)
  VR::ObjectInspector::ObjectInspectorGUI.new(obj).show_glade()
end

