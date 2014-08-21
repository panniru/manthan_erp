class LocationMastersController < ApplicationController
  
  def index
    @location_master = LocationMaster.all
  end

  def show
  end
  
  def new
    @location_master = LocationMaster.new
  end

  def create
    @location_master = LocationMaster.new(location_params)
    if @location_master.save
      flash[:success] = I18n.t :success, :scope => [:location_master, :create]
      redirect_to location_masters_path
    else
      render "index"
    end
  end
  
  def destroy
    if @location_master.destroy
      flash[:success] = I18n.t :success, :scope => [:location_master ,:destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:location_master, :destroy]
    end
    redirect_to location_masters_path
  end
  
  def location_params
    location_params = params.require(:location_master).permit( :location_name )
  end
end

