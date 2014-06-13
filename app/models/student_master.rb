class StudentMaster < ActiveRecord::Base
  belongs_to :parent
  belongs_to :grade_master
  has_one :parent_payment_master, :foreign_key => :student_id

  def grade_bucket_id
    GradeBucketMapping.find_by_grade_master_id(self.grade_master).fee_grade_bucket_id
  end

end
