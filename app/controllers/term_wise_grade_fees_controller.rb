class TermWiseGradeFeesController < ApplicationController

  def term_wise_fee_of_student
    student = StudentMaster.find(params[:student_id]);
    respond_to do |format|
      format.json do
        total = 0.0
        term_wise_fees = TermWiseGradeFee.belongs_to_fee_grade_bucket(GradeBucketMapping.find_by_grade_master_id(student.grade_master).fee_grade_bucket_id).map do |term_fee|
          total = total + term_fee.amount_in_rupees
          {:term => term_fee.term_definition.term_definition, :amount_in_rupees => term_fee.amount_in_rupees}
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
        status = ""
        if term_wise_fee_list.map(&:valid?).all?
          term_wise_fee_list.each(&:save)
          status = "202"
        else
          status = "404"
        end
        render :json => status
      end
    end
  end
  
end
