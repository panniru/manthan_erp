class GradeActivityMapping < ActiveRecord::Base
  belongs_to :grade_master  
  belongs_to :activity_master
end
