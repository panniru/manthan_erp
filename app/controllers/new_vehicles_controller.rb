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
  
  def home
    @locations = Location.all
    gmap_data = Gmaps4rails.build_markers(@locations) do |location, marker|
      
      marker.lat location.location_master.latitude
      marker.lng location.location_master.longitude
      marker.infowindow location.get_bus_no
      
      marker.title location.location_master.location_name
      marker.picture({
                       :url => "http://maps.google.com/mapfiles/ms/icons/red-dot.png" ,
                       :width   => 40,
                       :height  => 40,
                       
                     })
    end
    gon.gmap_data = gmap_data.to_json
    gon.width = "600px"
    gon.height = "400px"
  end

  def edit
    @new_vehicle = NewVehicle.find(params[:id])
  end
  
  def get_vendor_name
    vendor = VendorManagement.all.map do |vendor|
      {id: vendor.id , vendor_name: vendor.vendor_name}
    end
    render :json => vendor
  end

  def vehicle_params
    params.require(:new_vehicle).permit(:make_of_bus,:model_no,:year_of_manufacture,:purchase_option,:purchase_option_date,:capacity)
  end
end
