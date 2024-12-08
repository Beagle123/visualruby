
require "vrlib"

require_relative "src/AlertBoxDemo.rb"

main = Gtk::Application.new("org.visualruby.main")
main.signal_connect "activate" do |app|
  app = AlertBoxDemo.new.show_glade()
end
main.run 
