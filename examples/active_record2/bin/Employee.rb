
class Employee < ActiveRecord::Base
	has_many :paychecks
	belongs_to :employer

	include GladeGUI

	def visual_attributes
		bal = balance().to_f
		hash = { :text => name }
		hash[:foreground] = (bal < 0) ? "white" : "black"
    hash[:background] = (bal < 0) ? "red" : "white"
		return hash
	end

	def balance()
		Paycheck.sum(:amount, :conditions => "employee_id = #{id}").round(2).to_s
#		Paycheck.find("employee_id = #{id}").calculate(:sum, :amount).round(2).to_s
	end

end
