
class ObjectInspectorGUI
  
  include GladeGUI

  def initialize(obj)
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
