#library of gtk3 components


require "gtk3"
require "require_all"
require "date"


start = Time.now

require_rel 'lib/'



#my_path = File.expand_path(File.dirname(__FILE__))
#require_all Dir.glob(my_path + "/lib/**/*.rb")
puts "Require Time After vrlib included:  " + (Time.now - start).to_s 
