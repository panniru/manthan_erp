class CanteenManagementsController < ApplicationController
  def index   
    @canteen_managements = CanteenManagement.all 
    respond_to do |format|
      format.json do
        render :json => @canteen_managements
      end
      format.html do
      end
    end
  end
  def new
    @canteen_management = CanteenManagement.new
  end
  def create
    @canteen_management = CanteenManagement.new(canteenmanagement_params)
    if @canteen_management.save
      flash[:success] = I18n.t :success, :scope => [:canteenmanagement, :create]
      redirect_to canteenmanagements_path
    else
      render "new"
    end
  end
  def edit
    @canteen_management = CanteenManagement.find(params[:id])
  end
  def destroy
    @canteen_management = CanteenManagement.find(params[:id])
    @canteen_management.destroy
    respond_to do |format|
      format.html { redirect_to canteen_managements_path }
    end
  end
  def update
    @canteen_management = CanteenManagement.find(params[:id])
    respond_to do |format|
      if @canteen_management.update(canteenmanagement_params)
        format.html { redirect_to canteenmanagements_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
      else
        format.html { render action: 'edit' }
        format.json { render json: @canteen_management.errors, :status => "failure" }
      end
    end
  end
 
  def create_bulk 
    @canteen_bulk = build_canteen_from_bulk
    if !@canteen_bulk.empty? and @canteen_bulk.map(&:valid?).all?
      @canteen_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:canteen_management, :create_bulk]
      redirect_to canteen_managements_path
    else
      flash[:fail] = I18n.t :fail, :scope => [:canteen_management, :create_bulk]
      render "new"   
      
    end
  end
  
  
  def canteenmanagement_params
    params.require(:canteen_managements).permit(:meal_name, :time, :description) 
  end

  def  build_canteen_from_bulk
    params.require(:bulk_meal).select{|canteen_management| canteen_management["meal_name"].present? and canteen_management["time"].present? and canteen_management["description"]}.map do |canteen_management| CanteenManagement.new(canteen_management.permit(:meal_name, :time, :description) )
    end
  end

def home_index
  @canteen_managements = CanteenManagement.all
end
end
