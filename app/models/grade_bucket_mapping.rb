class GradeBucketMapping < ActiveRecord::Base
  belongs_to :grade_master
  belongs_to :fee_grade_bucket

  scope :belongs_to_grades, lambda{ |grades = []| 
    where("grade_master_id IN(?)", grades) unless grades.empty?
  }

  def self.generate_mapping
    GradeMaster.all.each do |grade|
      gbm = GradeBucketMapping.new
      gbm.grade_master = grade
      gbm.fee_grade_bucket = FeeGradeBucket.find_grade_bucket_by_grade(grade.id.to_s)
      gbm.save!
    end
  end

end
