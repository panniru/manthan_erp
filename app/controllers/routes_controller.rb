class RoutesController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  def index
    respond_to do |format|
      @route = Route.paginate(:page => params[:page].present? ? params[:page] : 1)
      @map_data = GoogleMapProcessor.build_map_data(@route)
      gon.gmap_data = @map_data.to_json
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
    @route = Route.new(route_params)
    if @route.save
      flash.now[:success] = I18n.t :success, :scope => [:route, :create]
      redirect_to  routes_path
    else
      render "new"
    end
  end
  
  def create_bulk
    @route_bulk = build_route_from_bulk
    if !@route_bulk.empty? and @route_bulk.map(&:valid?).all?
      @route_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:route, :create_bulk]
      redirect_to routes_path
    else
      flash[:fail] = I18n.t :fail, :scope => [:route, :create_bulk]
      render "new"
    end
  end


  def edit
  end

 
  def route_params
    params.require(:route).permit( :route_no , :lpp, :busno_up , :no_of_children ,:start_point , :end_point)
  end
  
  def build_route_from_bulk
    params.require(:bulk_route).select{|route| route["lpp"].present? }.map do |route|
      Route.new(route)
    end
  end
end
