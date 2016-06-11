
# ignore -- this is for development, same as require 'vrlib'
require File.exists?("./../../vrlib/vrlib.rb") ?  "./../../vrlib/vrlib.rb" : "vrlib"

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
:database => "db/development.sqlite3"
) 


CompanyGUI.new.show_glade()

# This code just populates the database

#ActiveRecord::Schema.define do
#    create_table :employers do |table|
#      table.column :name, :string
#      table.column :address, :string
#      table.column :company_type, :string
#    end
#    create_table :employees do |table|
#      table.column :employer_id, :integer
#      table.column :name, :string
#      table.column :address, :string
#    end
#    create_table :paychecks do |table|
#      table.column :employee_id, :integer
#      table.column :date, :date
#      table.column :description, :string
#      table.column :amount, :float
#    end
#
#end
#
#p = Employer.create
#p.name = "Hal's Lawnmowers"
#p.address = "4675 St Bernard Wy, Lincoln, NE 83748"
#p.company_type = "Home and Garden"
#p.save
#
#e = p.employees.create
#e.name = "Kenny Arthur"
#e.address = "11430 W Foothill, San Mateo CA 90054"
#e.save
#
#c = e.paychecks.create
#c.date = DateTime.new(2011, 12, 18)
#c.description = "Cash Advance"
#c.amount = 400
#c.save
#
#c = e.paychecks.create
#c.date = DateTime.new(2011, 11, 25)
#c.description = "November Hours"
#c.amount = -545.56
#c.save
#
#c = e.paychecks.create
#c.date = DateTime.new(2011, 11, 28)
#c.description = "Payment"
#c.amount = 900
#c.save
#
#e = p.employees.create
#e.name = "Albert Davidson"
#e.address = "324 Sheffield Blvd, San Francisco CA 90048"
#e.save
#
#c = e.paychecks.create
#c.date = DateTime.new(2011, 12, 28)
#c.description = "Payment: Christmas Bonus"
#c.amount = 500
#c.save
#
#c = e.paychecks.create
#c.date = DateTime.new(2011, 11, 25)
#c.description = "November Hours"
#c.amount = -755.56
#c.save
#
#c = e.paychecks.create
#c.date = DateTime.new(2011, 11, 28)
#c.description = "Payment"
#c.amount = 1000
#c.save
#
#p = Employer.create
#p.name = "99 cent Supermart"
#p.address = "222 Cleveland Blvd, Foster City, CA 96858"
#p.company_type = "Discount Stores"
#p.save
#
#e = p.employees.create
#e.name = "Richard King"
#e.address = "490 S Brooks Blvd, San Francisco CA 90044"
#e.save
#
#c = e.paychecks.create
#c.date = DateTime.new(2011, 9, 18)
#c.description = "Payment: Overtime"
#c.amount = 500
#c.save
#
#c = e.paychecks.create
#c.date = DateTime.new(2011, 11, 25)
#c.description = "November Hours"
#c.amount = -485.56
#c.save
#
#c = e.paychecks.create
#c.date = DateTime.new(2011, 11, 28)
#c.description = "December Hours"
#c.amount = -756.56
#c.save
#
#
#e = p.employees.create
#e.name = "Angel Cervantes"
#e.address = "1984 99th Blvd, Sacremento, CA 95558"
#e.save
#
#c = e.paychecks.create
#c.date = DateTime.new(2011, 11, 28)
#c.description = "Payment: November"
#c.amount = 750
#c.save
#
#c = e.paychecks.create
#c.date = DateTime.new(2011, 11, 25)
#c.description = "November Hours"
#c.amount = -855.56
#c.save
#
#
#
