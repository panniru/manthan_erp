class ParentCheque < ActiveRecord::Base
  belongs_to :post_dated_cheque
  belongs_to :parent_payment_transaction
  validates :cheque_number, :presence => true
  validate :validate_parent_cheque_no
  
  scope :belongs_to_student, lambda{|student_id| where(:student_id => student_id)}
  scope :pending_cheques, lambda{where(:status => "pending")}
  scope :cleared_cheques, lambda{where(:status => "cleared")}
  scope :cheques_on_or_before, lambda{|cheque_date| where("cheque_date <= ?", cheque_date.strftime('%Y-%m-%d'))}
  scope :cheques_on_or_after, lambda{|cheque_date| where("cheque_date >= ?", cheque_date.strftime('%Y-%m-%d'))}

  scope :multi_search_parent_student_cheque_number, lambda { |term|
    where_clause = "lower(student_masters.name) ILIKE '%#{term.downcase}%' OR lower(parent_masters.father_name) ILIKE '%#{term.downcase}%' OR lower(parent_masters.mother_name) ILIKE '%#{term.downcase}%' OR lower(parent_cheques.cheque_number) ILIKE '%#{term.downcase}%'"
    joins(parent_payment_transaction: [parent_payment_master: [:parent, :student]]).where(where_clause)
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

  private
  
  def parent_master
    @parent_master ||= parent_payment_transaction.parent_payment_master.parent
  end
  
  def validate_parent_cheque_no
    parent_master.parent_payment_masters.each do |payment_masters|
      if payment_masters.parent_payment_transactions.transactions_on_cheque(cheque_number, bank_name).count > 0
        self.errors[:cheque_number] << (I18n.t(:cheque_exists, :scope => [:parent_payment_masters, :cheque], :cheque_number => cheque_number, :bank_name => bank_name))
      end
    end
  end
end
