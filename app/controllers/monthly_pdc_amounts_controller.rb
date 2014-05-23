class MonthlyPdcAmountsController < ApplicationController
  
  def monthly_pdc_amounts
    respond_to do |format|
      format.json do
        p "================>>"
        p MonthlyPdcGrid.new.get_grid[0]
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
