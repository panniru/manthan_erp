class PfStatement < ActiveRecord::Base
  belongs_to :faculty_master
  belongs_to :payslip

  scope :sort_on_employee_code, lambda{ includes(:faculty_master).order("faculty_masters.code")}
  
  def self.pf_statement_applicable_date(date)
    if Payslip.in_the_current_month(date).count > 0
      date
    else
      date.prev_month
    end
  end

  def new_entrance?
    faculty_master.date_of_joining.month == payslip.generated_date.month and faculty_master.date_of_joining.year == payslip.generated_date.year
  end

  def exit?
    faculty_master.resignation_date.present? and faculty_master.resignation_date.month == payslip.generated_date.month and faculty_master.resignation_date.year == payslip.generated_date.year
  end
  
end
