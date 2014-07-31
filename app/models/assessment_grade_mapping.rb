class AssessmentGradeMapping < ActiveRecord::Base
	 belongs_to :grade_master 
	 belongs_to :assessment_type
end
