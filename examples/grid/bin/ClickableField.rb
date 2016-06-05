
# note event masks don't work on Gtk::Label


class ClickableField < Gtk::EventBox

	def initialize(text)
		super()
		@label = Gtk::Label.new(text)
		add(@label)
		signal_connect("button_press_event") { self__clicked }
		show_all
#		@box.above_child = true
	end


end
