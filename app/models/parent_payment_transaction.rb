class ParentPaymentTransaction < ActiveRecord::Base
  belongs_to :parent_payment_master
  has_one :parent_cheque
  has_one :term_definition, :foreign_key => :term_definition_id

  scope :bolongs_to_parent_payment_master, lambda{|parent_payment_master| where(:parent_payment_master_id => parent_payment_master)}
end
