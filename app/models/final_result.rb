class FinalResult < ActiveRecord::Base
  belongs_to :student_master
  belongs_to :grading_default
  belongs_to :assessment_type
  

end
