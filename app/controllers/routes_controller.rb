class RoutesController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  def index
    respond_to do |format|
      @routes = Route.all
      #@map_data = GoogleMapProcessor.build_map_data(@route)
      @your_hash = [{ location:'vijayawada', stopover:true},{ location:'khammam', stopover:true},{ location:'secunderabad', stopover:true}]
      gon.waypts = @your_hash
      #gon.gmap_data = @map_data.to_json
      gon.width = "750px"
      gon.height = "350px"
      
      format.json do
        render :json => Route.all
      end
      format.html do 
        render "index"
      end
    end
  end
  
  def show
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
      p route_params
      @route= Route.new(route_params)
      @route.add_locations(params[:locations])
      format.json do
        
        #
        render :json => @route.save
      end
      format.html do
         if @route.save
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
    p "===============>"
    p params
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
    params.require(:bulk_location).select{|locations| route["location"].present? and route["sequence_no"].present? }.map do |route|
      Location.new(location)
    end
  end
end
