class AssessmentResult < ActiveRecord::Base
	belongs_to :student_master
	belongs_to :grading_master
	belongs_to :assessment_listing
end
