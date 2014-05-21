class GradeWiseFee < ActiveRecord::Base
  belongs_to :fee_grade_bucket
  belongs_to :fee_type

  
  
  scope :find_by_fee_bucket_id_and_fee_type_id, lambda{|bucket, fee_type| where("fee_grade_bucket_id = ? and fee_type_id = ?", bucket.id, fee_type.id)}

  def self.make_object_with_grade_and_fee_type(grade, fee_type)
    grade_wise_fee = GradeWiseFee.new
    grade_wise_fee.fee_grade_bucket = grade
    grade_wise_fee.fee_type = fee_type
    grade_wise_fee
  end
  
end
