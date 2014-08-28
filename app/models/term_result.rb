class TermResult < ActiveRecord::Base
	belongs_to :student_master
	belongs_to :grading_master
	belongs_to :academic_term
	belongs_to :assessment_criteria
end
