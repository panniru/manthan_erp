class TeacherGradeMapping < ActiveRecord::Base  
  belongs_to :grade_master
  belongs_to  :section_master
  belongs_to  :subject_master
  belongs_to  :faculty_master

  scope :belongs_to_faculty, lambda{|faculty| where(:faculty_master_id => faculty)}
end
