class DiscountCalculator < Struct.new(:grade)

  def get_discount
    grade_bucket_id =  GradeBucketMapping.find_by_grade_master_id(grade).fee_grade_bucket_id
    grade_total_fee = GradeWiseFee.belongs_to_fee_grade_bucket(grade_bucket_id).sum(:amount_in_rupees)
    discount = Discount.first.discount_percent
    discount_amount = ((discount/100)*grade_total_fee)
    GradeDescountDetail.new(:percentage => discount, :discount_amount => discount_amount, :total_amount => grade_total_fee, :amount_to_be_paid => (grade_total_fee - discount_amount))
  end

  private

  class GradeDescountDetail
    include Virtus.model
    attribute :percentage, String
    attribute :discount_amount, Float
    attribute :total_amount, Float
    attribute :amount_to_be_paid, Float
  end
  
end
