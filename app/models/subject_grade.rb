class SubjectGrade < ActiveRecord::Base
  belongs_to :subject_master  
  belongs_to :grade_master  
  def union
    "#{grade_master_id} - #{subject_master_id}"
  end
end
