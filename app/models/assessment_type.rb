class AssessmentType < ActiveRecord::Base
	validates :assessment_type, presence: true, uniqueness: true
end
