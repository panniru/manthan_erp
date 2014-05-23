class TermWiseGradeFeesController < ApplicationController

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
