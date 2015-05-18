class StudentRouteMappingsController < ApplicationController
  def index
    @student_route_mappings = StudentRouteMapping.all.paginate(:page => params[:page], :per_page => 10)
    @student_masters = StudentMaster.select('DISTINCT id')
    @routes = Route.select('DISTINCT id')
  end
  
  def get_up_route_view
    routes = Location.equals_to_location_master(params[:id]).up_routes.map {|location| location.route}
    route = routes.map do |r|
      {id: r.id ,  busno_up: r.busno_up , lpp: r.lpp, student_length: r.bus_capacity_up}
    end                   
    render :json => route
  end
  
  def get_route_optimization
    utilization = StudentRouteMapping.all.map do |r|
      [ r.route.busno_up , r.route.student_length  ]
    end
    render :json => [utilization]
  end

  def location_bus_mapping
    location = StudentRouteMapping.all.map do |r|
      [ r.location_master.location_name ,  r.route.busno_up ]
    end
    render :json => [location] 
  end
    
   
  def get_down_route_view
    routes = Location.equals_to_location_master(params[:id]).down_routes.map {|location| location.route}
    route = routes.map do |r|
      {id: r.id ,  busno_down: r.busno_down , lpp: r.lpp, student_length: r.bus_capacity_down}
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
    location = StudentRouteMapping.all.map do |r|
      [ r.route.busno_up , r.location_master.location_name  ]
    end
    render :json => [location] 
  end

  def save_route
    @new=StudentRouteMapping.new()
    @new.route_id = params[:route_id]
    @new.student_master_id = params[:student_master_id]
    @new.location_master_id = params[:location_master_id]
    @new.lpp = params[:lpp]
    @new.save
    render :json =>  true
  end
  
  def get_student_view
    page = params[:page].present? ? params[:page] : 1
    @students = StudentMaster.has_bus_facility.has_no_route.all.paginate(:page => page , :per_page => 4)
    respond_to do |format|
      data = {}
      format.json do
        students = @students.map do |student|
          {name: student.name,id: student.id , grade: student.grade_master.grade_name , section: student.section_master.section_name }
        end
        data[:students] = students
        render :json => JsonPagination.inject_pagination_entries(@students, data)
      end
      format.html do
        render "get_student_view"
      end
    end
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
    mapping_params = params.require(:student_route_mapping).permit( :route_id , :student_master_id , :location_master_id , :lpp )
  end
  
end
