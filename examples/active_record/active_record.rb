require 'vrlib.rb'
require 'active_record'

#make program output in real time so errors visible in VR.
STDOUT.sync = true
STDERR.sync = true

#everything in these directories will be included
my_path = File.expand_path(File.dirname(__FILE__))
require_all Dir.glob(my_path + "/lib/**/*.rb") 
require_all Dir.glob(my_path + "/bin/**/*.rb") 

ActiveRecord::Base.establish_connection(  
:adapter => "sqlite3",    
:database => "db/development.sqlite3",
)

ChoosePerson.new.show


#ActiveRecord::Schema.define do
#    create_table :people do |table|
#      table.column :name, :string
#      table.column :address, :string
#			table.column :phone, :string
#			table.column :email, :string
#    end
#end
#
#p = Person.create
#p.name = "Beaufort Klinkscale"
#p.address = "4675 St Bernard Wy, Lincoln, NE 83748"
#p.phone = "384-4859"
#p.email = "beaubeau@klink.com"
#p.save
#
#p = Person.create
#p.name = "Alex Frederickson"
#p.address = "675 Westgate, Alexandria, VA 94844"
#p.phone = "844-4839"
#p.email = "alex@visualruby.net"
#p.save
#
#p = Person.create
#p.name = "Tony Williams"
#p.address = "12 Harvard Ct., Hemet, CA 94849"
#p.phone = "435-4439"
#p.email = "bigtony@yahoooo.com"
#p.save
#
#
#
