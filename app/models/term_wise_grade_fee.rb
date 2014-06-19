class TermWiseGradeFee < ActiveRecord::Base
  belongs_to :fee_grade_bucket
  belongs_to :term_definition
  
  scope :belongs_to_fee_grade_bucket, lambda{|bucket| where("fee_grade_bucket_id = ?", bucket)}
  scope :belongs_to_term_difinition, lambda{|term| where("term_definition_id = ?", term)}
  scope :student_unpaid_terms_in_transactions, lambda{|parent_payment_transactions| where("term_definition_id NOT IN(?)", parent_payment_transactions.map(&:term_definition_id))}
  scope :student_unpaid_terms_in_parent_cheques, lambda{|parent_cheques| where("term_definition_id NOT IN(?)", parent_cheques.map(&:term_definition_id))}

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
