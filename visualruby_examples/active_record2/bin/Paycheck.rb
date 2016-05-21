
class Paycheck < ActiveRecord::Base
	belongs_to :employee

	include GladeGUI

	def to_s
		sprintf("%.2f", amount)
	end

end
