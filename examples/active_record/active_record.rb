

# ignore -- this is for development, same as require 'vrlib'
require File.exists?("./../../lib/vrlib.rb") ?  "./../../lib/vrlib.rb" : "vrlib"

begin
  require 'active_record'
  require 'sqlite3'
rescue LoadError
  alert "You must install activerecord gem to use this example.  " +
      "Just enter at command prompt:\n\n<b>gem install activerecord\ngem install sqlite3</b>"
  exit
end

# from require_all gem:
require_rel 'bin/'


ActiveRecord::Base.establish_connection(  
:adapter => "sqlite3",    
:database => "db/development.sqlite3",
)

ChoosePerson.new.show_glade()


#ActiveRecord::Schema.define do
#    create_table :people do |table|
#      table.column :name, :string
#      table.column :address, :string
#      table.column :phone, :string
#      table.column :email, :string
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
