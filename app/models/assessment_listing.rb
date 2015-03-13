class AssessmentListing < ActiveRecord::Base
	validates :assessment_id, uniqueness: true
	belongs_to :faculty_master 
	belongs_to :grade_master 
	belongs_to :section_master
    belongs_to :subject_master
	belongs_to :assessment
end
