
class TextWidget < Gtk::Box


	def initialize(text)
		@text = text
		super(:horizontal, 1)
		show_label
	end

	def show_label()
		@evt.destroy if @evt
		@evt = Gtk::EventBox.new()
		@label = Gtk::Label.new(@text)
		@label.xalign = 0
		@evt.add(@label)		
		@evt.signal_connect("button_press_event")  { show_entry() }		
		pack_start(@evt, :expand => false)
		show_all
	end


	def show_entry()
		@evt.destroy
		@evt = Gtk::EventBox.new()
		@entry = Gtk::Entry.new()
		@entry.text = @text
#		@entry.height = @label.height
		@evt.add(@entry)
		@evt.signal_connect("button_press_event")  { show_label() }					
		pack_start(@evt, :expand => false)
		show_all
	end


end

