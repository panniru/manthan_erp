class AssessmentTeacherMapping < ActiveRecord::Base
	belongs_to :faculty_master 
	belongs_to :grade_master 
	belongs_to :section_master
    belongs_to :subject_master
	belongs_to :assessment_type

end
