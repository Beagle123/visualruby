
class SongListViewGUI < SongListView

	include GladeGUI

	def before_show
		@builder["scrolledwindow1"].add(self)
	end

	def self__row_activated(*args)
		return unless rows = selected_rows
		row = rows[0]
		alert "You selected\n#{row[:song]}\nby  #{row[:artist]}"
	end

	def invisible__toggled(*args)
		v = !@builder["invisible"].active?
		col_visible(:last_name => v, :first_name => v ) 
	end

	def radio__toggled(*args)
		ren_radio(:check => @builder["radio"].active?)
		each_row { |r| r[:check] = false }
		repaint
	end

	def background__toggled(*args)
		val = @builder["background"].active? ? "yellow" : "white"
		ren_attr(:song, :background => val) # same as set_background( SONG => val)
		repaint
	end

	def xalign__toggled(*args)
		val = @builder["xalign"].active? ? 1 : 0
		ren_xalign(:artist => val)
		repaint
	end

	def bold__toggled(*args)
		val = @builder["bold"].active? ? Pango::WEIGHT_BOLD : Pango::WEIGHT_NORMAL
		ren_weight(:song => val) #number from 100 to 900, BOLD = 700
		repaint	
	end

	def center__toggled(*args)
		val = @builder["center"].active? ? 0.5 : 0
		col_alignment(:artist => val) 
		repaint
	end
	
	def editable__toggled(*args)
		ren_editable(!@builder["editable"].active?)		
	end

	def digits__toggled(*args)
		val = @builder["digits"].active? ? 1 : 0
		ren_digits(:quantity => val)
		repaint
	end

	def repaint
		@builder["scrolledwindow1"].hide
		@builder["window1"].show_all
	end
end


