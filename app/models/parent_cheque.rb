class ParentCheque < ActiveRecord::Base
  belongs_to :post_dated_cheque
  belongs_to :parent_payment_transaction
  belongs_to :parent_payment_master
  
  scope :belongs_to_student, lambda{|student_id| where(:student_id => student_id)}
  scope :pending_cheques, lambda{where(:status => "pending")}
  scope :cheques_on_or_before, lambda{|cheque_date| where("cheque_date <= ?", cheque_date.strftime('%Y-%m-%d'))}
  scope :cheques_on_or_after, lambda{|cheque_date| where("cheque_date >= ?", cheque_date.strftime('%Y-%m-%d'))}

  scope :multi_search_parent_student_cheque_number, lambda { |term|
    where_clause = "lower(student_masters.name) ILIKE '%#{term.downcase}%' OR lower(parents.father_name) ILIKE '%#{term.downcase}%' OR lower(parents.mother_name) ILIKE '%#{term.downcase}%' OR lower(parent_cheques.cheque_number) ILIKE '%#{term.downcase}%'"
    includes(parent_payment_master: [:parent, :student]).where(where_clause)
  }

  def cleared?
    self.status == "cleared"
  end
  
  def clear_cheque
    return false if cleared?
    ActiveRecord::Base.transaction do
      # payment_transaction = new_parent_payment_transaction_from_cheque
      # payment_transaction.save!
      
      self.status = "cleared"
      self.parent_payment_transaction.clear_transaction
      self.save!
      self.save!
    end
  end

  # def new_parent_payment_transaction_from_cheque
  #   payment_transaction = ParentPaymentTransaction.new(:transaction_date => DateTime.now, :amount_in_rupees => self.amount_in_rupees, :transaction_type => "cheque");
  #   payment_transaction.parent_payment_master = self.parent_payment_master
  #   payment_transaction
  # end

  def self.parent_cheque_params(params)
    params.permit(:cheque_number, :cheque_date, :bank_name, :ifsc_code)
  end

end
