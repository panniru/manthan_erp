class ParentPaymentMaster < ActiveRecord::Base
  validates :payment_type_id, :presence => true
  belongs_to :parent 
  belongs_to :student, :class_name => "StudentHr"
  belongs_to :payment_type
  has_many :parent_pdcs
  has_many :parent_payment_transactions
  accepts_nested_attributes_for :parent_pdcs
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
    student = StudentHr.find(params[:student_id])
    pmnt_type = PaymentType.find(params[:payment_type_id])
    payment_master.parent= student.parent
    payment_master.student = student
    payment_master.payment_type = pmnt_type
    if pmnt_type.code == "annual"
    elsif pmnt_type.code == "term_wise"
      payment_master.add_payment_transaction(params[:parent_payment_transaction])
    elsif pmnt_type.code == "monthly"
      payment_master.add_parent_pdc_entries(params[:parent_pdcs], student)
    end
    payment_master
  end

  def update_parent_payment_master(params)
    if annual_payment?
    elsif term_wise_payment?
      add_payment_transaction(params[:parent_payment_transaction])
    elsif monthly_payment?
      add_parent_pdc_entries(params[:parent_pdcs], self.student)
    end
  end

  def add_payment_transaction(transaction_params)
    self.parent_payment_transactions << ParentPaymentTransaction.new(:transaction_date => DateTime.now, :amount_in_rupees => transaction_params[:amount_in_rupees], :transaction_type => "cash", :payment_detail_id => transaction_params[:payment_detail_id], :particulars => transaction_params[:particulars]);
  end

  def add_parent_pdc_entries(parent_pdc_params, student)
    parent_pdc_params.each do |pdc|
      if pdc[:cheque_number].present?
        self.parent_pdcs << ParentPdc.new(:cheque_number => pdc[:cheque_number], :post_dated_cheque_id => pdc[:post_dated_cheque_id],:parent_id => student.parent.id, :student_id => student.id)
      end
    end
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
