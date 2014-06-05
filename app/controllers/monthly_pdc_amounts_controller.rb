class MonthlyPdcAmountsController < ApplicationController
  

  def month_wise_fee_of_student
    student_id = params[:student_id]
    student = StudentHr.find(params[:student_id]);
    respond_to do |format|
      format.json do
        total = 0.0
        month_wise_fees = MonthlyPdcAmount.belongs_to_fee_grade_bucket(FeeGradeBucket.find_grade_bucket_by_grade(student.grade)).map do |month_fee|
          total = total + month_fee.amount_in_rupees
          {:month => month_fee.post_dated_cheque.month, :amount_in_rupees => month_fee.amount_in_rupees}
        end
        render :json => Struct.new(:month_fee_details, :total).new(month_wise_fees, Formatter.two_decimal(total))
      end
    end
  end
  
  def monthly_pdc_amounts
    respond_to do |format|
      format.json do
        render :json => MonthlyPdcGrid.new.get_grid
      end
    end
  end

  def save_monthly_pdc_amounts
    respond_to do |format|
      monthly_pdc_list = MonthlyPdcGrid.get_object_list_from_grid(params[:params], "2014-15")
      format.json do
        status = ""
        if monthly_pdc_list.map(&:valid?).all?
          monthly_pdc_list.each(&:save)
          status = "202"
        else
          status = "404"
        end
        render :json => status
      end
    end
  end
  
end
