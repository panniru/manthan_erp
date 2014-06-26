class TermWiseGradeFeesController < ApplicationController

  def term_wise_fee_of_student
    student = StudentMaster.find(params[:student_id]);
    respond_to do |format|
      format.json do
        s_f_c = StudentFeeCalculator.new(student)
        total = s_f_c.applicable_total_fee
        term_wise_fees = TermWiseGradeFee.belongs_to_fee_grade_bucket(student.grade_bucket_id).map do |term_fee|
          {:term => term_fee.term_definition.term_definition, :amount_in_rupees => s_f_c.applicable_term_fee(term_fee)}
        end
        render :json => Struct.new(:term_fee_details, :total).new(term_wise_fees, Formatter.two_decimal(total))
      end
    end
  end
  

  def term_wise_grade_fee
    respond_to do |format|
      format.json do
        render :json => TermFeeGrid.new.get_grid
      end
    end
  end


  def save_term_wise_fee_grid
    respond_to do |format|
      term_wise_fee_list = TermFeeGrid.get_object_list_from_grid(params[:params], "2014-15")
      format.json do
        status = []
        if term_wise_fee_list.map(&:valid?).all?
          status = term_wise_fee_list.map(&:save)
        end
        flash[:success] = I18n.t :success, :scope => [:term_wise_grade_fee, :create]
        render :json => status
      end
    end
  end
    
  end
