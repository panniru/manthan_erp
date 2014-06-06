class StudentHrsController < ApplicationController
  load_resource :only => [:show, :monthly_pdcs, :next_term_fee]
  def index
    if current_user.admin?
      @student_hrs = Student.all
    elsif current_user.parent?
      @student_hrs = current_user.parent.students
    end
  end

  def show
    respond_to do |format|
      format.json do
        render :json => @student_hr
      end
      format.html do
        render "show"
      end
    end
  end

  def monthly_pdcs
    payment_master = @student_hr.parent_payment_master
    respond_to do |format|
      format.json do
        monthly_pdcs = []
        if payment_master.present?
          monthly_pdcs = MonthlyPdcAmount.belongs_to_fee_grade_bucket(FeeGradeBucket.find_grade_bucket_by_grade(@student_hr.grade)).pending_pdc_submissions(@student_hr).map do |pdc_amount|
            Struct.new(:post_dated_cheque_id, :month, :amount_in_rupees, :cheque_number, :clearence_date).new(pdc_amount.post_dated_cheque_id, pdc_amount.post_dated_cheque.month, pdc_amount.amount_in_rupees, nil ,nil)
          end
        else
          monthly_pdcs = MonthlyPdcAmount.belongs_to_fee_grade_bucket(FeeGradeBucket.find_grade_bucket_by_grade(@student_hr.grade)).map do |pdc_amount|
            Struct.new(:post_dated_cheque_id, :month, :amount_in_rupees, :cheque_number, :clearence_date).new(pdc_amount.post_dated_cheque_id, pdc_amount.post_dated_cheque.month, pdc_amount.amount_in_rupees, nil ,nil)
          end
        end
        render :json => monthly_pdcs
      end
    end
  end
  
  def next_term_fee
    payment_master = @student_hr.parent_payment_master
    respond_to do |format|
      format.json do
        term_wise_amount = nil
        unless payment_master.present?
          term_wise_amount = TermWiseGradeFee.belongs_to_fee_grade_bucket(FeeGradeBucket.find_grade_bucket_by_grade(@student_hr.grade)).order("term_definition_id").first
        else
          term_wise_amount = TermWiseGradeFee.belongs_to_fee_grade_bucket(FeeGradeBucket.find_grade_bucket_by_grade(@student_hr.grade)).order("term_definition_id").student_unpaid_terms(payment_master).first
        end
        render :json => Struct.new(:term_definition_id, :amount_in_rupees, :term, :term_date).new(term_wise_amount.term_definition_id, term_wise_amount.amount_in_rupees, term_wise_amount.term_definition.term_definition)
      end
    end  
  end
  
  
end
