 class RoutesController < ApplicationController
   load_resource :only => [:show, :update, :edit, :destroy, :locations]
   
   def index
     @student_route_mappings = StudentRouteMapping.where(:route_id => params[:route_id]).count
     if current_user.transport_head? 
       @routes=  Route.all
       @locations = Location.all
       locations = []
       Route.all.each do |route| 
         locations.concat(route.locations)
       end
       gmap_data = Gmaps4rails.build_markers(locations) do |location, marker|
         marker.lat location.location_master.latitude
         marker.lng location.location_master.longitude
       end
       gon.gmap_data = gmap_data.to_json
       gon.width = "750px"
       gon.height = "350px"
       respond_to do |format|   
         format.json do
           routes = @routes.map do |r|
             {id: r.id ,  busno_up: r.busno_up, start_location: r.start_location.location_master.location_name , end_location: r.end_location.location_master.location_name}
           end
           render :json => routes
         end
         format.html do 
           render "index"
         end
       end
     end
     if current_user.admin? 
       @routes =  Route.all
       @locations = Location.all
       locations = []
       Route.all.each do |route| 
         locations.concat(route.locations)
       end
       gmap_data = Gmaps4rails.build_markers(locations) do |location, marker|
         marker.lat location.location_master.latitude
         marker.lng location.location_master.longitude
       end
       gon.gmap_data = gmap_data.to_json
       gon.width = "750px"
       gon.height = "350px"
       respond_to do |format|   
         format.json do
           routes = @routes.map do |r|
             {id: r.id ,  busno_up: r.busno_up, start_location: r.start_location.location_master.location_name , end_location: r.end_location.location_master.location_name}
           end
           render :json => routes
         end
         format.html do 
           render "index"
         end
       end
     end
     if current_user.parent?
       respond_to do |format|   
         format.json do
           current_user.parent.students.each do |student|
             studentroutemappings = StudentRouteMapping.where('student_master_id = '+"#{student.id}")
             studentroutemappings = studentroutemappings.all.map do |route|
               p "====================="
               p route.route_id
               @routes = Route.where('id = '+"#{route.route_id}")
               p @routes
             end
           end
           routes = @routes.map do |r|
             {id: r.id ,  busno_up: r.busno_up, start_location: r.start_location.location_master.location_name , end_location: r.end_location.location_master.location_name}
           end
           p "@@@@@@@@@@@@2"
           p routes
           render :json => routes
         end
         format.html do 
           render "index"
         end
       end  
     end
   end
   
   def send_mail
     respond_to do |format|
       route_mail= params[:route_mail]
       mailing_job = RouteMailingJob.new(current_user.user_id, DateTime.now, route_mail[:subject], route_mail[:text])
       Delayed::Job.enqueue mailing_job, mailing_job.job_run_id
       #UserMailer.welcome(route_mail[:subject] ,route_mail[:text]).deliver
       result_link = "<a href=\"/job_runs/#{mailing_job.job_run_id}\">here</a>"
       msg = I18n.t :success, :scope => [:job, :schedule], job: "Route Mailing Job", result_link: result_link
       format.json do
         render :json => {msg: msg}
       end
       format.html do
         flash[:success] = msg.html_safe
         redirect_to routes_path
       end
     end
   end
 
     
   def get_location_view
     var = LocationMaster.all.map do |var|
       {location_name: var.location_name,id: var.id}
     end
     render :json => var
   end
   
   def get_bus_no
     var = NewVehicle.all.map do |var|
       {id: var.id}
     end
     render :json => var
   end
   
   def show
     @route = Route.find(params[:id])
     @location = Location.all
     @location = []
     @route.locations.each do |location|
       @location.push({location: location.location_master.location_name})
     end
     gon.start_point_latitude = @route.start_location.location_master.latitude.to_s 
     gon.start_point_longitude =@route.start_location.location_master.longitude.to_s
     gon.end_point_latitude = @route.end_location.location_master.latitude.to_s 
     gon.end_point_longitude = @route.end_location.location_master.longitude.to_s
     gon.waypts = @location.to_json
     gon.width = "750px"
     gon.height = "350px"
   end
   
   def update
     respond_to do |format|
       format.json do
         render :json => {:status => @route.update_route(params)}
       end
       format.html do
       end
     end
   end
   
   def all_students
     respond_to do |format|
       format.json do 
         map = StudentRouteMapping.show_all_students(params[:route]).map {|student| student.student_master_id}
         students = StudentMaster.where(:id => map ).each.map do |mapping|
           {grade: mapping.grade_master.grade_name,  name: mapping.name , section: mapping.section_master.section_name , location: mapping.location_master.location_name}
         end     
         render :json => students
       end
     end
   end
   
   def all_locations
     respond_to do |format|
       format.json do 
         loc = StudentRouteMapping.show_all_locations(params[:location]).map {|student| student.student_master_id}
         p "===================="
         p loc
         locations = StudentMaster.where(:id => loc ).each.map do |mapping|
           {grade: mapping.grade_master.grade_name,  name: mapping.name , section: mapping.section_master.section_name }
         end     
         render :json => locations
       end
     end
   end
   
       
   def students
   end
     
   def destroy
     if @route.destroy
       flash[:success] = I18n.t :success, :scope => [:route ,:destroy]
     else
       flash.now[:fail] = I18n.t :fail, :scope => [:route, :destroy]
     end
     redirect_to routes_path
   end
   
   def create
     respond_to do |format|
       @route= Route.new(route_params)
       status = @route.save_route(params[:locations])
       format.json do
         render :json => status
       end
       format.html do
         if status
           flash.now[:success] = I18n.t :success, :scope => [:route, :create]
           redirect_to  routes_path
         else
           render "new"
         end
         render :json => nil
       end
     end
   end
   
   def edit
   end
   
   def get_route_locations
     respond_to do |format|
       format.json do
         @route = Route.find(params[:id])
         route_locations = @route.locations
         render :json => route_locations
       end
     end
   end

   private
      
   def route_params
     route_params = params.require(:route).permit(:route_no , :busno_up, :lpp)
   end
   
   def build_route_from_bulk
     params.require(:locations).select{|locations| location["location_master_id"].present? and route["sequence_no"].present? }.map do |params|
       location = Location.new(params[:location].permit(:location_master_id, :sequence_no , :route_id))
       route = Route.new(params[:route].permit(:route_no, :busno_up))
       route.locations << location
       route
     end
   end
 end
 
 
