
require "vrlib"

require_relative "src/DataObjectGUI"


form = DataObjectGUI.new("Harry Milktoast", "123 Main, San Clemente, CA 90090",
     "harvey@harveyserver.com", "132-243-4323") 
form.show_glade()


