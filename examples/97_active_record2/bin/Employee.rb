
class Employee < ActiveRecord::Base
  has_many :paychecks
  belongs_to :employer

  include GladeGUI

  def each_cell(col, ren, model, iter)
    bal = balance().to_f
    ren.text = name
    ren.foreground = bal < 0 ? "white" : "black"
    ren.background = bal < 0 ? "red" : "white"
  end

  def balance()
    Paycheck.sum(:amount, :conditions => "employee_id = #{id}").round(2).to_s
  end

end
