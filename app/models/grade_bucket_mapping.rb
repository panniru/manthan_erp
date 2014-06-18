class GradeBucketMapping < ActiveRecord::Base
  belongs_to :grade_master
  belongs_to :fee_grade_bucket

  scope :belongs_to_grades, lambda{ |grades = []| 
    where("grade_master_id IN(?)", grades) unless grades.empty?
  }

end
