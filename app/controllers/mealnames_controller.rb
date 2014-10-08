class MealnamesController < ApplicationController
  def index
    @mealnames = Mealname.all
    @meal = @mealnames.group_by { "current_date" }
  end
  def new
    @mealnames = Mealname.new
  end
  def create   
    @mealnames = Mealname.new(mealname_params)
    if @mealnames.save
      flash[:success] = I18n.t :success, :scope => [:mealname, :create]
      redirect_to mealnames_path
    else
      #render "new"
    end
  end
  def show
    @mealnames = Mealname.all
  end

  def destroy
    @mealnames = Mealname.find(params[:id])    
    respond_to do |format|
      format.json do
        render :json =>  @mealnames.destroy
      end
      format.html do
        if @mealnames.destroy
          flash[:success] = I18n.t :success, :scope => [:mealname ,:destroy]
        else
          flash.now[:fail] = I18n.t :fail, :scope => [:mealname, :destroy]
        end
        redirect_to mealnames_path
      end
    end
  end
  
  def get_meal_names
    respond_to do |format|
      format.json do 
        meal = Mealname.all
        #select("canteen_date, count(*) as data").group("canteen_date")
        meals = meal.each.map do |mapping|
          { id: mapping.id, meal_detail_name: mapping.meal_detail_name , canteen_date: mapping.canteen_date}
        end  
        render :json => meals
      end
    end
  end
  

  def mealname_params
    params.require(:mealnames).permit(:mealtype_id, :meal_detail_name, :canteen_date)
  end
  def canteenmanagerdata
    respond_to do |format|
      format.json do
        canteenmanager_data = Mealname.select(:canteen_date).where("trim(to_char(canteen_date, 'Month')) = '#{params[:month]}'").distinct              
        canteenmanager_data =  canteenmanager_data.map do |canteenmanager|
          {start: canteenmanager.canteen_date, title: "plan", description: "plan", url: "#", canteen_date: canteenmanager.canteen_date}
        end      
        render :json =>  canteenmanager_data
      end
      
    end
  end

  def canteen_date
    respond_to do |format|
      format.json do
        canteen_date = Mealname.where("canteen_date = '#{params[:date]}'")
        canteen_date = canteen_date.map do |canteen|
          {id: canteen.canteen_date, meal_type_id: canteen.meal_type_id, meal_detail_name: canteen.meal_detail_name }
        end    
        p"=============="
        p canteen_date
        render :json => canteen_date
      end
    end
  end
  def getmealtypeidservice
    respond_to do |format|
      format.json do                   
        mealtype_id = Mealtype.all        
        mealtype_id = mealtype_id.map do |meal|
          {id: meal.id,mealtype: meal.meal_type}
        end       
        render :json => mealtype_id
      end
    end
  end
  def create_bulk    
    @mealname_bulk = build_mealname_from_bulk

    @mealname_bulk.each{|meal| p meal; p meal.errors;}
    if !@mealname_bulk.empty? and @mealname_bulk.map(&:valid?).all?
      @mealname_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:mealname, :create_bulk]
      redirect_to mealnames_path
    else      
      flash[:fail] = I18n.t :fail, :scope => [:mealname, :create_bulk]
     # render "new"   
    end
  end

  def build_mealname_from_bulk
    params.require(:bulk_meal).select{|mealname| mealname["mealtype_id"].present? and mealname["meal_detail_name"].present?}.map do |mealname| 
      Mealname.new(mealname.permit(:mealtype_id, :meal_detail_name)) do |meal|

        meal.canteen_date = params[:canteen_date]
      end
    end
    
  end
  
  
end
