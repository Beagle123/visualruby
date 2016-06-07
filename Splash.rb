
require "gtk3"



window = Gtk::Window.new()
window.add Gtk::Image.new(:file => "img/splash.png")
window.signal_connect("destroy") { Gtk.main_quit }
window.show_all



$t = Thread.new {
	puts "Before sleep"
	sleep(6)
	puts "after sleep"
#	window.destroy 
	Gtk.main_quit
	puts "After Quit"
}
$t.join


Gtk.main


