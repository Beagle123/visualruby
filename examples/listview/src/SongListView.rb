##
# This class contains all the code for the ListView itself.
# It sets-up the columns and data.
# The GUI class will make changes to the view/data.
# All the GUI code is in SongListViewGUI.rb.  
#

class SongListView < VR::ListView


  AUDIO_ICON = GdkPixbuf::Pixbuf.new(:file => File.dirname(__FILE__) + "/audio-x-generic.png")


  def initialize 
    @cols = {}
    @cols[:pix] = {:pix => GdkPixbuf::Pixbuf, :song => String } #two renderers in this column
    @cols[:date] = VR::Col::CalendarCol # DateTime
    @cols[:artist] = String
    @cols[:first_name] = String    
    @cols[:last_name] = String
    @cols[:popular] = VR::Col::ProgressCol
    @cols[:buy] = VR::Col::ComboCol
    @cols[:quantity] = VR::Col::SpinCol
    @cols[:price] = VR::Col::CurrencyCol
    @cols[:check] = TrueClass
    super(@cols)

    col_sort_column_id(:artist => id(:last_name), :song => id(:song), :first_name=> id(:first_name))
    col_sort_column_id(:last_name => id(:last_name), :popular => id(:popular))
    col_sort_column_id(:last_name => id(:last_name), :popular => id(:popular), :buy=> id(:buy))
    col_sort_column_id(:check => id(:check), :date => id(:date))
    col_sort_column_id(:price => id(:price), :check => id(:check), :date => id(:date))
    col_sort_column_id(:quantity => id(:quantity))
    col_title(:first_name => "First", :last_name => "Last", :check => "Ok", :quantity => "Qty")
    ren_width(:popular => 80, :check=> 20, :buy => 80, :quantity=>90)
#    ren_attr(:price, :edit_inline => true)
    ren_editable(true)
  
    # this block executes after ARTIST is edited ("edited" event).   
    renderer(:artist).edited_callback = Proc.new { | model_col, iter |
        names = iter[id(:artist)].split
        iter[id(:first_name)] = names[0]
        iter[id(:last_name)] = names[1]
    }
    
    # this block must evaluate to true to allow updating.
    renderer(:artist).validate_block = Proc.new { |text, model_col, iter, view| 
      if text.split.size == 2 # insist on two names
        true
      else
        alert("You must enter two names.", :parent => self)
        false
      end 
    } 
    refresh()
    self.visible = true
  end    

  # this just loads the data into the model
  def refresh()
    data = get_data() # returns array of songs
    (0..6).each do |i|
      row = model.append # add_row()
      row[id(:pix)] = AUDIO_ICON   
      row[id(:first_name)] = data[i][0]
      row[id(:last_name)] = data[i][1]
      row[id(:artist)] = row[id(:first_name)] + " " + row[id(:last_name)]
      row[id(:song)] = data[i][2]
      row[id(:quantity)] = VR::Col::SpinCol.new(0,0,100,1) # Gtk::Adjustment.new(0,0,100,1,0,0)  # 
      row[id(:price)] = VR::Col::CurrencyCol.new(2.99)
      row[id(:popular)] = data[i][3]
      row[id(:buy)] = VR::Col::ComboCol.new("Buy", "Buy", "Rent", "Listen") # all rows use the same combobox
      row[id(:check)] = false
      row[id(:date)] = VR::Col::CalendarCol.new(data[i][4], :format => "%d %b %Y ", :hide_time=>true, :hide_date => false)
    end

  end


  def get_data
    rows = []
    rows << ["Iggy", "Pop", "I Wanna Be Your Dog", 88, DateTime.new(1981,11,21)]
    rows << ["Joe", "Cocker", "You Are So Beautiful", 91, DateTime.new(1973,12,7)]
    rows << ["Elvis", "Costello", "Pump it Up", 77, DateTime.new(1982, 5, 5)]
    rows << ["Paul", "McCartney", "Silly Love Songs", 69, DateTime.new(1979,7,13)]
    rows << ["Dorothy", "Moore", "Misty Blue", 97, DateTime.new(1981, 1, 14)]
    rows << ["Rod", "Stewart", "Hot Legs", 54, DateTime.new(1982, 9, 27)]
    rows << ["Lionel", "Richie", "Three Times a Lady", 84, DateTime.new(1978, 1, 3)] 
  end

end



