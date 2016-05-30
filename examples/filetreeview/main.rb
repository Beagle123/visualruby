#!/usr/bin/ruby

# ignore -- this is for development, same as require 'vrlib'
require File.exists?("./../../vrlib/vrlib.rb") ?  "./../../vrlib/vrlib.rb" : "vrlib"
require 'find'


# from require_all gem:
require_rel 'bin/'


ProjectTreeGUI.new.show

