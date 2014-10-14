class LocationsController < ApplicationController
  def index
  end

  def create
  end
  
  def destroy
    @location = Location.find(params[:id])
    if @location.destroy
      flash[:success] = I18n.t :success, :scope => [:location ,:destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:location, :destroy]
    end
    redirect_to routes_path
  end

end
