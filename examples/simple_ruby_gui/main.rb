#!/usr/bin/ruby


require "vrlib"

# from require_all gem:
require_rel 'bin'


form = DataObjectGUI.new("Harvey Milktoast", "123 Main, Hemet, CA 90090",
     "harvey@harveyserver.com", "132-243-4323") 
form.show_glade()


