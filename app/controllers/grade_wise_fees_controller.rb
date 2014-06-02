class GradeWiseFeesController < ApplicationController

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
