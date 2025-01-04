require "./../../lib/vrlib.rb"

require_relative "src/Phantom.rb"

main = Gtk::Application.new("org.visualruby.phantom_demo", :handles_open)
main.signal_connect "activate" do |app|  
  HelloGUI.new.show_ui(app)
end
main.run 

