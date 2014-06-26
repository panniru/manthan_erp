class DiscountCalculator < Struct.new(:student)

  def get_discount
    grade_total_fee = StudentFeeCalculator.new(student).applicable_total_fee
    discount = DefaultMaster.find_by_default_name("discount").present? ? DefaultMaster.find_by_default_name("discount"). default_value.to_f : 0.0
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
