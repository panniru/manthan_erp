class LeaveEncashment < ActiveRecord::Base
  
  scope :belongs_to_employee , lambda{|faculty| where(:faculty_master_id => faculty )}
  scope :in_the_year, lambda{|year| where("to_char(date, 'YYYY') = ?", year)}
  scope :employee_leave_encashments, lambda{|faculty, year| select(:no_of_leaves_to_be_encashed).belongs_to_employee(faculty).in_the_year(year)}
  scope :generated_after, lambda{|date| where("generated_date > ?", date)}
  
end
