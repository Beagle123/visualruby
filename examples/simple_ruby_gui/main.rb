#!/usr/bin/ruby

#Updated for Gtk3!

# ignore -- this is for development, same as require 'vrlib'
require File.exists?("./../../lib/vrlib.rb") ?  "./../../lib/vrlib.rb" : "vrlib"

# from require_all gem:
require_rel 'bin/'


x = DataObjectGUI.new("Harvey Milktoast", "123 Main, Hemet, CA 90090",
     "harvey@harveyserver.com", "132-243-4323") 
x.show_glade()


