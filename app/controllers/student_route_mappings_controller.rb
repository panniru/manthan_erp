class StudentRouteMappingsController < ApplicationController
  def index
    @student_route_mappings = StudentRouteMapping.all
  end
  
  def get_route_view
    routes = Location.equals_to_location_master(params[:id]).map {|location| location.route}
    render :json => routes
  end
  
  def create
    Location.equals_to_location_master(params[:location_master_id])
    @student_route_mapping = StudentRouteMapping.new(mapping_params)
    if @student_route_mapping.save
      flash[:success] = I18n.t :success, :scope => [:student_route_mapping, :create]
      redirect_to student_route_mappings_path
    end
  end
  
  def show
  end

  def save_route
    p "=====================><"
    p params
    @new=StudentRouteMapping.new()
    @new.route_id = params[:route_id]
    @new.student_master_id = params[:student_master_id]
    @new.save
    render :json =>  true
  end
  

  private
  
  def mapping_params
    mapping_params = params.require(:student_route_mapping).permit( :route_id , :student_master_id  )
  end
  
end
