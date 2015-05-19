class GradeSection < ActiveRecord::Base
  belongs_to :grade_master  
  belongs_to :section_master
  def union
    "#{grade_master_id} - #{section_master_id}"
  end
  
end
