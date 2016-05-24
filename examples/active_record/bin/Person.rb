class Person < ActiveRecord::Base

		include GladeGUI

		def before_show
			set_glade_all()
		end

		def to_s
			"#{self.name}  (#{self.email})" 
		end

end
