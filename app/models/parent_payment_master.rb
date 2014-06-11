class ParentPaymentMaster < ActiveRecord::Base
  validates :payment_type_id, :presence => true
  belongs_to :parent 
  belongs_to :student, :class_name => "StudentMaster"
  belongs_to :payment_type
  has_many :parent_cheques
  has_many :parent_payment_transactions
  accepts_nested_attributes_for :parent_cheques
  accepts_nested_attributes_for :parent_payment_transactions
  
  def self.new_student_payment_master(student_id)
    payment_master = ParentPaymentMaster.new
    payment_master.student_id = student_id
    payment_master
  end

  def set_next_payment_date
    if self.payement_type.code == "term_wise"
      
    elsif self.payement_type.code == "monthly"
    end
  end
  
  def self.prepare_payment_master(params)
    payment_master = ParentPaymentMaster.new
    student = StudentMaster.find(params[:student_id])
    pmnt_type = PaymentType.find(params[:payment_type_id])
    payment_master.parent= student.parent
    payment_master.student = student
    payment_master.payment_type = pmnt_type
    if pmnt_type.code == "annual" or pmnt_type.code == "term_wise"
      if params[:parent_payment_transaction][:transaction_type] == "cash" 
        payment_master.add_payment_transaction(params[:parent_payment_transaction])
      else
        payment_master.add_parent_cheque_entries(params[:parent_cheques], student)
      end
    elsif pmnt_type.code == "monthly"
      payment_master.add_parent_cheque_entries(params[:parent_cheques], student)
    end
    payment_master
  end

  def update_parent_payment_master(params)
    if annual_payment?
    elsif term_wise_payment?
      add_payment_transaction(params[:parent_payment_transaction])
    elsif monthly_payment?
      add_parent_cheque_entries(params[:parent_cheques], self.student)
    end
  end

  def add_payment_transaction(transaction_params)
    self.parent_payment_transactions << ParentPaymentTransaction.new(:transaction_date => DateTime.now, :amount_in_rupees => transaction_params[:amount_in_rupees], :transaction_type => "cash", :payment_detail_id => transaction_params[:payment_detail_id], :particulars => transaction_params[:particulars]);
  end

  def add_parent_cheque_entries(parent_cheque_params, student)
    parent_cheque_params.each do |pdc|
      if pdc[:cheque_number].present?
        self.parent_cheques << generate_parent_cheque(pdc, student)
      end
    end
  end

  def generate_parent_cheque(cheque_params, student)
    parent_cheque = ParentCheque.new(cheque_params)
    # parent_cheque.parent = student.parent
    # parent_cheque.student = student
    parent_cheque
  end
  
  def term_wise_payment?
    payment_code == "term_wise"
  end

  def monthly_payment?
    payment_code == "monthly"
  end

  def annual_payment?
    payment_code == "annaul"
  end
  
  def payment_code
    self.payment_type.code
  end
  
end
