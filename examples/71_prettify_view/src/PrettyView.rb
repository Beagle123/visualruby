
class PrettyView < VR::ListView 
 
  include GladeGUI


  def initialize()
    super({ name: String, balance: Float })
    col_width(name: 160, balance: 120)
    col_attr(:balance, alignment: 1, xalign: 1)  # align header and numbers to right 
    refresh()
    self.visible = true
    each_cell_method(:balance, :balance, method(:make_negatives_red))
  end    

  # This method is called by Gtk on each cell.  It passes the Gtk::TreeViewColumn, the renderer etc.
  def make_negatives_red(col, rend, model, iter)

      col_id = id(rend.model_sym)
      balance = iter[col_id]

      if balance < 0
          rend.text = "(%.2f)" % balance.abs
          rend.foreground = "darkred" 
          rend.weight = 700
      else
          rend.text = "%.2f" % balance 
          rend.foreground = "black"
          rend.weight = 400 
      end

  end


  def before_show
    @builder["scrolledwindow1"].add_child(self)
  end

  # this just loads the data into the model
  def refresh()
    data = get_data() # returns array of songs
    (0..6).each do |i|
      row = model.append # add_row()
      row[id(:name)] = data[i][0]   
      row[id(:balance)] = data[i][1]
    end
  end


  def get_data
    rows = []
    rows << ["Iggy", 45.60]
    rows << ["Joe", 208.29]
    rows << ["Elvis", -56.23]
    rows << ["Paul", 782.45]
    rows << ["Dorothy", -129.01]
    rows << ["Rod", 55.87]
    rows << ["Lionel", 29.23] 
  end


end

