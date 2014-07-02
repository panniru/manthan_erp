class ParentPaymentTransaction < ActiveRecord::Base
  belongs_to :parent_payment_master
  has_one :parent_cheque
  has_one :term_definition, :foreign_key => :term_definition_id
  has_one :payment_receipt
  
  accepts_nested_attributes_for :parent_cheque
  
  scope :bolongs_to_parent_payment_master, lambda{|parent_payment_master| where(:parent_payment_master_id => parent_payment_master)}
  scope :cleared_transactions, lambda{where(:status => "cleared")}
  scope :cheque_type_transactions, lambda{where(:transaction_type => "cheque")}
  scope :pending_transactions, lambda{where(:status => "pending")}
  
  def fee_type_contribution_amounts
    parent_payment_master.fee_type_contribution_percentages.map do |fee_type|
      amount = (self.amount_in_rupees * (fee_type[:contribution_percent]/100))
      {:fee_type_id => fee_type[:fee_type_id], :fee_type => fee_type[:fee_type], :amount => amount}
    end
  end


  def clear_transaction
    update(:status => "cleared")
  end

  def online_payment?
    transaction_type == 'online'
  end

  def cash_payment?
    transaction_type == 'cash'
  end

  def cheque_payment?
    transaction_type == 'cheque'
  end

  
  
  
end
