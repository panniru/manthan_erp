class MonthlyPdcAmount < ActiveRecord::Base
  belongs_to :fee_grade_bucket
  belongs_to :post_dated_cheque
  
  scope :belongs_to_fee_grade_bucket, lambda{|bucket| where("fee_grade_bucket_id = ?", bucket)}
  scope :belongs_to_post_dated_cheque, lambda{|pdc| where("post_dated_cheque_id = ?", pdc)}
  # scope :pending_pdc_submissions, lambda{|student| where("post_dated_cheque_id NOT IN(?)", ParentCheque.belongs_to_student(student).map(&:post_dated_cheque_id))}
  

  def amount_real_value
    read_attribute(:amount_in_rupees)
  end

  # def amount_in_rupees
  #   (read_attribute(:amount_in_rupees).to_f/RuleEngine.new.value(:amount, :unit))
  # end
  
  # def amount_in_rupees=(amt)
  #   write_attribute(:amount_in_rupees, (amt.to_f * RuleEngine.new.value(:amount, :unit)))
  # end
  
end
