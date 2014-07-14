class ParentPaymentMaster < ActiveRecord::Base
  validates :payment_type_id, :presence => true
  belongs_to :parent 
  belongs_to :student, :class_name => "StudentMaster"
  belongs_to :payment_type
  has_many :parent_payment_transactions
  accepts_nested_attributes_for :parent_payment_transactions


  scope :payment_type_wise_count_and_sum, lambda{joins(:parent_payment_transactions).select("parent_payment_masters.payment_type_id, count(*) as count, sum(parent_payment_transactions.amount_in_rupees)as sum").group("parent_payment_masters.payment_type_id")}
  
  scope :belongs_to_grade, lambda{|grade| joins(:student).where("student_masters.grade_master_id = ?", grade)}
  scope :belongs_to_payment_type, lambda{|payment_type| where("payment_type_id = ?", payment_type)}


  
  def self.new_student_payment_master(student_id)
    payment_master = ParentPaymentMaster.new
    payment_master.student_id = student_id
    payment_master
  end
  
  
  def term_wise_payment?
    payment_code == "term_wise"
  end

  def monthly_payment?
    payment_code == "monthly"
  end

  def annual_payment?
    payment_code == "annual"
  end
  
  def payment_code
    self.payment_type.code
  end

  def next_term_fee(fee_grade_bucket = student.grade_bucket_id)
    term_wise_grade_fee = TermWiseGradeFee.belongs_to_fee_grade_bucket(fee_grade_bucket)
    term_wise_grade_fee = term_wise_grade_fee.student_unpaid_terms_in_transactions(parent_payment_transactions) unless parent_payment_transactions.empty?
    term_wise_grade_fee.first
  end

  def fee_type_contribution_percentages
    total = total_applicable_grade_fee
    contributions = []
    grade_wise_fees.each do |grade_fee|
      if student.fee_type_applicable?(grade_fee.fee_type.fee_type)
        percentage = (grade_fee.amount_in_rupees/total) * 100 
        contributions << {:fee_type_id => grade_fee.fee_type.id, :fee_type => grade_fee.fee_type.fee_type, :contribution_percent => percentage}
      end
    end
    contributions
  end

  def total_applicable_grade_fee
    grade_wise_fees.select{|grade_fee| student.fee_type_applicable?(grade_fee.fee_type.fee_type)}.inject(0.0){|sum, grade_fee| sum+grade_fee.amount_in_rupees}
  end

  def grade_wise_fees
    @grade_wise_fees ||= GradeWiseFee.belongs_to_fee_grade_bucket(student.grade_bucket_id)
  end
  
end
