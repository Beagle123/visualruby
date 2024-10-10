
class BalanceListView < VR::ListView 
 
  include GladeGUI


  def initialize 
    cols = { name: CustomerClass, balance: BalanceClass }
    super(cols)
    col_width(:name => 160, :balance => 120) 
    col_attr(:balance, alignment: 1, xalign: 1)
    col_editable(true)
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
      row[id(:name)] = CustomerClass.new(data[i][0], data[i][1], data[i][2])   
      row[id(:balance)] = BalanceClass.new(data[i][3])
    end

  end


  def get_data
    rows = []
    rows << ["Iggy", "123 Main St.", "CA", 45.60]
    rows << ["Joe", "4343 Magnolia Ave", "CA", 208.29]
    rows << ["Elvis", "3787 Graceland St.", "TN", -56.23]
    rows << ["Paul", "2929 Elm St.", "CA", 782.45]
    rows << ["Dorothy", "3749 23rd Ave", "CA", -129.01]
    rows << ["Rod", "487 Bushwood", "FL", 55.87]
    rows << ["Lionel", "1116 Haley Ct" , "CA" , 29.23] 
  end


end

