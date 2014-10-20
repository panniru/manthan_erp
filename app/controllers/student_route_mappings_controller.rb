class StudentRouteMappingsController < ApplicationController
  def index
    @student_route_mappings = StudentRouteMapping.all.paginate(:page => params[:page], :per_page => 10)
    @student_masters = StudentMaster.select('DISTINCT id')
    @routes = Route.select('DISTINCT id')
  end
  
  def get_route_view
    routes = Location.equals_to_location_master(params[:id]).map {|location| location.route}
    route = routes.map do |r|
      {id: r.id ,  busno_up: r.busno_up, student_length: r.bus_capacity }
    end
    render :json => route
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
    @new=StudentRouteMapping.new()
    @new.route_id = params[:route_id]
    @new.student_master_id = params[:student_master_id]
    @new.location_master_id = params[:location_master_id]
    @new.save
    render :json =>  true
  end
  
  def get_student_view
    student = StudentMaster.has_bus_facility.has_no_route.all.map do |student|
      {name: student.name,id: student.id , grade: student.grade_master.grade_name , section: student.section_master.section_name }
    end
    render :json => student
  end

  def destroy
    @student_route_mapping = StudentRouteMapping.find(params[:id])
    if @student_route_mapping.destroy
      flash[:success] = I18n.t :success, :scope => [:student_route_mapping ,:destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:student_route_mapping, :destroy]
    end
    redirect_to student_route_mappings_path
  end
   



  private
  
  def mapping_params
    mapping_params = params.require(:student_route_mapping).permit( :route_id , :student_master_id , :location_master_id )
  end
  
end
