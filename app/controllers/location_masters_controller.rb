class LocationMastersController < ApplicationController
  
  def index
   
    if  params[:id].present?
      @location_master = LocationMaster.where(id: params[:id]).paginate(:page => params[:page], :per_page => 14, :total_entries => LocationMaster.count)
    else
      @location_master = LocationMaster.order('location_name ASC').paginate(:page => params[:page], :per_page => 14, :total_entries => LocationMaster.count)
    end
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
    @location_master = LocationMaster.find(params[:id])
    if @location_master.destroy
      flash[:success] = I18n.t :success, :scope => [:location_master ,:destroy]
    else
      flash[:alert] = "Delete the corresponding Route of this Location"
    end
    redirect_to location_masters_path
  end


  def location_params
    location_params = params.require(:location_master).permit( :location_name , :index)
  end
end

