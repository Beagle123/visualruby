
class TableDemo < VR::Table

	include GladeGUI

#	AUDIO_ICON = Gdk::Pixbuf.new(File.dirname(__FILE__) + "/audio-x-generic.png")
#	AUDIO_ICON = Gtk::Image.new(File.dirname(__FILE__) + "/audio-x-generic.png")

	def initialize()
		super 
		width=200
		height= 200 
		self.add_events(:button_press_mask)
		self.column_spacing = 5
		refresh()
		parse_signals
		show
	end		

	def self__button_press_event(*a)
		alert "Hello"
	end

	def refresh()
		clear()
		data = get_data() # returns array of songs
		(0..6).each do |i|
			row = add_row()
  		row[:pix] = Gtk::Image.new(:file => File.dirname(__FILE__) + "/audio-x-generic.png")  
  		row[:first_name] = TextWidget.new(data[i][0])
  		row[:last_name] = ClickableLabel.new(data[i][1])
  		row[:artist] = ClickableLabel.new(data[i][0] + " " + data[i][1])
  		row[:song] = ClickableLabel.new(data[i][2])
#  		row[id(:quantity)] = VR::SpinCol.new(0,0,100,1) # Gtk::Adjustment.new(0,0,100,1,0,0)  # 
#			row[id(:price)] = VR::CurrencyCol.new(2.99)
#  		row[id(:popular)] = data[i][3]
#  		row[id(:buy)] = VR::ComboCol.new("Buy", "Buy", "Rent", "Listen") # all rows use the same combobox
#  		row[id(:check)] = VR::Checkfalse
#			row[id(:date)] = VR::CalendarCol.new(data[i][4], :format => "%d %b %Y ", :hide_time=>true, :hide_date => false)
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



