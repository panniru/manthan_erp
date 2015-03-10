class AssessmentCriteria < ActiveRecord::Base
  belongs_to :grade_master  
  belongs_to :subject_master
  
  validates :assessment_criteria, presence: true
end
