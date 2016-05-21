#!/usr/bin/ruby

#Updated for Gtk3!

require "vrlib"


#make program output in real time so errors visible in VR.
STDOUT.sync = true
STDERR.sync = true

#everything in these directories will be included
my_path = File.expand_path(File.dirname(__FILE__))
require_all Dir.glob(my_path + "/bin/**/*.rb") 

x = DataObjectGUI.new("Harvey Milktoast", "123 Main, Hemet, CA 90090", "harvey@harveyserver.com", "132-243-4323") 
x.show


