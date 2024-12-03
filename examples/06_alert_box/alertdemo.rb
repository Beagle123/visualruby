
require "vrlib"

require_relative "src/AlertBoxDemo.rb"



main = Gtk::Application.new()
main.signal_connect "activate" do |app|
  AlertBoxDemo.new.show_glade()
end
main.run 
