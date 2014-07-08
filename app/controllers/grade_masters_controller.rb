class GradeMastersController < ApplicationController

  def index
    respond_to do |format|
      format.json do
        render :json => GradeMaster.all
      end
    end
  end
end
