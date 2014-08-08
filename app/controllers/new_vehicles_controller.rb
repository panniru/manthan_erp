class NewVehiclesController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  
  def index
     @new_vehicle = NewVehicle.paginate(:page => params[:page].present? ? params[:page] : 1)
  end

  def show
  end
  
  def update
    if @new_vehicle.update(vehicle_params)
      flash[:success] = I18n.t :success, :scope => [:new_vehicle, :update]
      redirect_to new_vehicles_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:new_vehicle, :update]
      render "edit"
    end
  end
 
  def destroy
   if @new_vehicle.destroy
      flash[:success] = I18n.t :success, :scope => [:new_vehicle ,:destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:new_vehicle, :destroy]
    end
    redirect_to new_vehicles_path
  end
  
  def create
    @new_vehicle = NewVehicle.new(vehicle_params)
    if @new_vehicle.save
      redirect_to  new_vehicles_path
    else
      render "new"
    end
  end
  
  def edit
    @new_vehicle = NewVehicle.find(params[:id])
  end
  
   def vehicle_params
    params.require(:new_vehicle).permit(:make_of_bus,:model_no,:year_of_manufacture,:purchase_option,:purchase_option_date,:capacity)
  end
end
