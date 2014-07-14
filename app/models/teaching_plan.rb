class TeachingPlan < ActiveRecord::Base
belongs_to :grade_master	
belongs_to :section_master 
belongs_to :subject_master

end
