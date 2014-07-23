class GradeSubjectMapping < ActiveRecord::Base
  belongs_to :grade_master  
  belongs_to  :subject_master
end
