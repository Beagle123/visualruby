
class BetterView < VR::ListView 
 
  include GladeGUI


  def initialize()
    super({ name: String, balance: Float })
    col_width(name: 200, balance: 120) 
    ren_xalign(:balance => 1)
    refresh()
    self.visible = true
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

