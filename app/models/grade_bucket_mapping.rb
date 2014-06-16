class GradeBucketMapping < ActiveRecord::Base
  belongs_to :grade_master
  belongs_to :fee_grade_bucket
end
