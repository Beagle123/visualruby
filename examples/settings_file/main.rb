#!/usr/bin/ruby

# ignore -- this is for development, same as require 'vrlib'
require File.exists?("./../../vrlib/vrlib.rb") ?  "./../../vrlib/vrlib.rb" : "vrlib"


# from require_all gem:
require_rel 'bin/'

MainApp.new.show_glade()

