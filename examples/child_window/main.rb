#!/usr/bin/ruby

#Updated for Gtk3!

my_path = File.expand_path(File.dirname(__FILE__))
if my_path =~ /^\/home\/eric\/vrp\/.*/  
	require File.expand_path(my_path + "../../../../vrlib") + "/vrlib.rb"  
else
	require "vrlib"
end

#make program output in real time so errors visible in VR.
STDOUT.sync = true
STDERR.sync = true

my_path = File.expand_path(File.dirname(__FILE__))
require_all Dir.glob(my_path + "/bin/**/*.rb") 

ChildWindowDemo.new.show

