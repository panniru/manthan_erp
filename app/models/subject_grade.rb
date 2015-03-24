class SubjectGrade < ActiveRecord::Base
  belongs_to :subject_master  
  belongs_to :grade_master  
  
end
