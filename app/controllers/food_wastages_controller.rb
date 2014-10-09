class FoodWastagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json
  
  def index
    @food_wastages = FoodWastage.all 
  end

  def show
  end
  
  def create
    t = Time.now()
    current_date = t.strftime("%Y/%m/%d") 
    @new =  FoodWastage.new(:current_date => current_date)
    @new.wastage = params[:wastage]
    @new.save
    redirect_to new_food_wastage_path
  end
  
  def update
    if @food_wastage.update(food_params)
      flash[:success] = I18n.t :success, :scope => [:food_wastage, :update]
      redirect_to food_wastages_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:food_wastage, :update]
      render "edit"
    end
  end

  def edit
  end

  def new
  end
  

  def get_food_wastage
    respond_to do |format|
      @food_wastages = FoodWastage.all
      format.json do
        wastages = @food_wastages.map do |d|
          current = d.current_date.strftime('%s').to_i*1000
          [current, d.wastage]
        end
        render :json => [wastages]
      end
    end
  end
  
  private
  def food_params
    params.require(:food_wastage).permit(:wastage, :current_date ) 
  end
end
