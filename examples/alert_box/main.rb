#!/usr/bin/ruby

# ignore -- this is for development, same as require 'vrlib'
require File.exists?("./../../vrlib/vrlib.rb") ?  "./../../vrlib/vrlib.rb" : "vrlib"

# from require_all gem:
require_rel 'bin/'

alert "The file you selected is already on disk.  Do you want to overwrite it?",
    headline: "Overwrite FIle?",
    button_yes: "Overwrite",
    button_no: "Reload From Disk",
    button_cancel: "Cancel"


    
      

AlertBoxDemo.new.show_glade()

