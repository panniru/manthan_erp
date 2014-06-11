class ParentCheque < ActiveRecord::Base
  belongs_to :post_dated_cheque
  belongs_to :parent_payment_transaction
  belongs_to :parent_payment_master
  
  scope :bolongs_to_student, lambda{|student_id| where(:student_id => student_id)}
end
