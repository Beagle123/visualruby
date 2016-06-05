
class ClickableLabel < Gtk::EventBox

	include GladeGUI	

	def initialize(text)
		super()
		@label = Gtk::Label.new(text)
		@label.xalign = 0
		add(@label)
		show_all
		parse_signals
	end

	def self__button_press_event(*a)
		alert @label.label		
	end

end




#
#class ClickableLabel < Gtk::EventBox
#
#	def initialize(text)
#		super()
#		@label = Gtk::Label.new(text)
#		add(@label)
#		signal_connect("button_press_event") { self__clicked }
#		show_all
##		@box.above_child = true
#	end
#
#end
