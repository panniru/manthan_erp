class TermWiseGradeFee < ActiveRecord::Base
  belongs_to :fee_grade_bucket
  belongs_to :term_definition
  
  scope :belongs_to_fee_grade_bucket, lambda{|bucket| where("fee_grade_bucket_id = ?", bucket.id)}

  scope :belongs_to_term_difinition, lambda{|term| where("term_definition_id = ?", term.id)}
  
end
