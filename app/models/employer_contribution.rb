class EmployerContribution < ActiveRecord::Base
  scope :belongs_to_employee , lambda{|faculty| where(:faculty_master_id => faculty)}
  scope :generated_after, lambda{|date| where("generated_date > ?", date)}
end
