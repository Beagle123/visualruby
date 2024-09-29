

class TestWindow < VR_GtkWindow

  def change
    l = @builder["entry1"]
    l.text = "Chicken"
  end

  def button1__clicked(*args)
    test
    return
    @model = @builder["tree1"].model
    oinspect @model
    row = @model.append 
    row[0] = 23.5
    row[1] = 190
    @builder["tree1"].hide
    @builder["tree1"].show
    
  end

  def test
    @items_model = Gtk::ListStore.new(Integer, String)
    iter = @items_model.append
    iter[0] = 132
    iter[1] = "Chicken"
    @builder["tree1"].model = @item_model

  end


end
