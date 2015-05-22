class LabAssessmentGradeMapping < ActiveRecord::Base
  belongs_to :grade_master 
  belongs_to :lab_assessment

end
