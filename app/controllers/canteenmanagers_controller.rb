class CanteenmanagersController < ApplicationController
  def index
    @canteenmanagers = Canteenmanager.order("id DESC").all
  end
  def new
    @canteenmanager = Canteenmanager.new
  end
  def create
    @canteenmanager = Canteenmanager.new(canteenmanager_params)
    if @canteenmanager.save
      flash[:success] = I18n.t :success, :scope => [:canteenmanager, :create]
      redirect_to canteenmanagers_path
    else
      render "new"
    end
  end

  def destroy
    @canteenmanager = Canteenmanager.find(params[:id])    
    respond_to do |format|
      format.json do
        render :json => @canteenmanager.destroy
      end
      format.html do
        if @canteenmanager.destroy
          flash[:success] = I18n.t :success, :scope => [:canteenmanager ,:destroy]
        else
          flash.now[:fail] = I18n.t :fail, :scope => [:canteenmanager, :destroy]
        end
        redirect_to canteenmanagers_path
      end
    end
  end
  
  def canteenmanager_params
    params.require(:canteenmanager).permit(:canteen_date, :breakfast, :lunch,:snacks, :dinner)
  end
  def canteenmanagerdata
    respond_to do |format|
      format.json do
        canteenmanager_data = Canteenmanager.select(:canteen_date).where("trim(to_char(canteen_date, 'Month')) = '#{params[:month]}'").distinct              
        canteenmanager_data =  canteenmanager_data.map do |canteenmanager|
          {start: canteenmanager.canteen_date, title: "plan", description: "plan", url: "#", canteen_date: canteenmanager.canteen_date}
        end
        p  canteenmanager_data
        p "&&&&&&&&&&&&&&&&"
        render :json =>  canteenmanager_data
      end
      
    end
  end

  def canteen_date
    respond_to do |format|
      format.json do
        canteen_date = Canteenmanager.where("canteen_date = '#{params[:date]}'")
        canteen_date = canteen_date.map do |canteen|
          {id: canteen.canteen_date, breakfast: canteen.breakfast, lunch: canteen.lunch, snacks: canteen.snacks, dinner: canteen.dinner}
        end
        p canteen_date
        p "&&&&&&&"
        render :json => canteen_date
      end
    end
  end
  
end
