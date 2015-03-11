class HomeController < ApplicationController
  
  def index
    if params[:context].present? and params[:context] == "HRM"
      render "hrm_index"
    else
      render "index"
    end
  end
 
end
