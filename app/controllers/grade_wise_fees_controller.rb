class GradeWiseFeesController < ApplicationController

  def grade_wise_fee_of_student
    student = StudentHr.find(params[:student_id]);
    respond_to do |format|
      format.json do
        total = 0.0
        fee_details = GradeWiseFee.belongs_to_fee_grade_bucket(FeeGradeBucket.find_grade_bucket_by_grade(student.grade)).map do |fee|
          total = total + fee.amount_in_rupees
          {:fee_type => fee.fee_type.fee_type, :amount_in_rupees => fee.amount_in_rupees}
        end
        render :json => Struct.new(:grade, :fee_details, :total).new("Grade-"+student.grade.to_s, fee_details, Formatter.two_decimal(total))
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
