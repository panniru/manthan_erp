class TeacherGradeMapping < ActiveRecord::Base
  belongs_to :grade_master
  belongs_to  :section_master
end
