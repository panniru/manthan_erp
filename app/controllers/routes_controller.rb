 class RoutesController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]

   def index
     if current_user.admin?
       @routes =  Route.all
     else current_user.parent?
       current_user.parent.students.each do |student|
         studentroutemappings = StudentRouteMapping.where('student_master_id = '+"#{student.id}")
         studentroutemappings = studentroutemappings.all.map do |route|
           {temp: route.route_id }
         end
         p studentroutemappings[0][:temp]
         id = 19
         render "show/id"
       end
     end
     @routes =  Route.all
     locations = []
     Route.all.each do |route| 
       locations.concat(route.locations)
     end
     gmap_data = Gmaps4rails.build_markers(locations) do |location, marker|
       marker.lat location.location_master.latitude
       marker.lng location.location_master.longitude
     end
     
     
     #p gmap_data
     gon.gmap_data = gmap_data.to_json
     gon.width = "750px"
     gon.height = "350px"
     respond_to do |format|   
       format.json do
         render :json => Route.all
       end
       format.html do 
         render "index"
       end
     end
  end
   
   def get_location_view
     var = LocationMaster.all.map do |var|
       {location_name: var.location_name,id: var.id}
     end
     render :json => var
   end
   
   def show
     @route = Route.find(params[:id])
     @location = Location.all
     @location = []
     @route.locations.each do |location|
       @location.push({:location => location.location_master.location_name})
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
     if @route.update(route_params)
       flash[:success] = I18n.t :success, :scope => [:route, :update]
       redirect_to routes_path
     else
       flash.now[:fail] = I18n.t :fail, :scope => [:route, :update]
       render "edit"
     end
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
   
   def create_bulk
     @route_bulk = build_route_from_bulk
     if !@route_bulk.empty? and @route_bulk.map(&:valid?).all?
       @route_bulk.each(&:save!)
       flash[:success] = I18n.t :success, :scope => [:locations, :create_bulk]
       redirect_to routes_path
     else
       flash[:fail] = I18n.t :fail, :scope => [:locations, :create_bulk]
       render "new"
     end
   end
   
   
   def edit
   end
   
   private
   
   def route_params
     route_params = params.require(:route).permit( :route_no , :busno_up , :no_of_children )
   end
   
   def build_route_from_bulk
     params.require(:bulk_location).select{|locations| location["location_master_id"].present? and route["sequence_no"].present? }.map do |route|
       Location.new(location)
     end
   end
 end
 
 
