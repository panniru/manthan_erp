class TeachersTimeTable < ActiveRecord::Base
  scope :dynamic_day_on_grade_section, lambda{|day, g_s_str| where("#{day}_grade_section".to_sym => g_s_str) }
  scope :belongs_to_faculty_master, lambda{|faculty_master_id| where(:faculty_master_id => faculty_master_id) }
end
