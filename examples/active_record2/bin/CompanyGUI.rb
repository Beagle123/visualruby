
class CompanyGUI

  include GladeGUI


  def before_show()
    @employer_view = VR::ListView.new(:employer => Employer, :address => String, :company_type => String)
    @builder["scroll_employer"].add(@employer_view)
#    @employer_view.selection.signal_connect("changed") { employer_view__changed }
    @employer_view.col_width(:employer => 160, :address => 340, :company_type => 180)

    @employee_view = VR::ListView.new(:employer => Employer, :employee => Employee, :address => String, :balance => String)
    @builder["scroll_employee"].add(@employee_view)
##    @employee_view.selection.signal_connect("changed") { employee_view__changed }
    @employee_view.col_width(:employer => 160, :employee => 150, :address => 320)

    @paycheck_view = VR::ListView.new(:employee => Employee, :date => DateTime, :description => String, :amt => Paycheck)
    @builder["scroll_paycheck"].add(@paycheck_view)
    @paycheck_view.col_width(:employee => 200, :date => 100, :description => 220, :amt => 100)

    Employer.all.each do |e|
      row = @employer_view.add_row
      row[:employer] = e
      row.load_object(e)
    end
    @builder[:window1].show_all
#    @employer_view.select_row()
  end


  def employer_view__cursor_changed(*a)
    return unless row = @employer_view.selected_rows[0]
    @employee_view.model.clear
    Employee.where(:employer_id => row[:employer].id).each do |e|
      row = @employee_view.add_row
      row[:employee] = e
      row.load_object(e)
    end
#    @employee_view.select_row(0)
  end

  def employee_view__cursor_changed(*a)
    return unless row = @employee_view.selected_rows[0]
    @paycheck_view.model.clear
    Paycheck.where(:employee_id => row[:employee].id).each do |e|
      row = @paycheck_view.add_row
      row.load_object(e) #this loads employee object
      row[:amt] = e
    end
  end


end
