class GradeWiseFeesController < ApplicationController

  def grade_wise_fee_of_student
    student = StudentMaster.find(params[:student_id]);
    respond_to do |format|
      format.json do
        total = 0.0
        fee_details = GradeWiseFee.belongs_to_fee_grade_bucket(student.grade_bucket_id).map do |fee|
          amount = student.fee_type_applicable?(fee.fee_type.fee_type) ? fee.amount_in_rupees : 0
          total = total + amount
          {:fee_type => fee.fee_type.fee_type, :amount_in_rupees => amount}
        end
        render :json => Struct.new(:grade, :fee_details, :total).new("Grade-"+student.grade_master.grade_name.to_s, fee_details, Formatter.two_decimal(total))
      end
    end
  end
  
  def grade_wise_fee_view
    respond_to do |format|
      format.json do
        render :json => GradeFeeGrid.new.get_grid
      end
    end
  end

  def save_grade_wise_fee_grid
    respond_to do |format|
      grade_wise_fee_list = GradeFeeGrid.get_object_list_from_grid(params[:params], "2014-15")
      format.json do
        status = ""
        if grade_wise_fee_list.map(&:valid?).all?
          grade_wise_fee_list.each(&:save)
          status = "202"
        else
          status = "404"
        end
        render :json => status
      end
    end
  end
end
