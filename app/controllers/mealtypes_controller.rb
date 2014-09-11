class MealtypesController < ApplicationController
 def index   
    @mealtypes = Mealtype.all 
    respond_to do |format|
      format.json do
        render :json => @mealtypes
      end
      format.html do
      end
    end
  end
  def new
    @mealtype = Mealtype.new
  end
  def create
    @mealtype = Mealtype.new(mealtype_params)
    if @mealtype.save
      flash[:success] = I18n.t :success, :scope => [:mealtype, :create]
      redirect_to mealtypes_path
    else
      render "new"
    end
  end
  def edit
    @mealtype = Mealtype.find(params[:id])
  end
  def destroy
    @mealtype = Mealtype.find(params[:id])
    @mealtype.destroy
    respond_to do |format|
      format.html { redirect_to mealtypes_path }
    end
  end
  def update
    @mealtype = Mealtype.find(params[:id])
    respond_to do |format|
      if @mealtype.update(mealtype_params)
        format.html { redirect_to mealtypes_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mealtype.errors, :status => "failure" }
      end
    end
  end
 
  def create_bulk 
    @canteen_bulk = build_canteen_from_bulk
    if !@canteen_bulk.empty? and @canteen_bulk.map(&:valid?).all?
      @canteen_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:mealtype, :create_bulk]
      redirect_to mealtypes_path
    else
      flash[:fail] = I18n.t :fail, :scope => [:mealtype, :create_bulk]
      render "new"   
      
    end
  end
  
  
  def mealtype_params
    params.require(:mealtype).permit(:meal_type, :time) 
  end

  def  build_canteen_from_bulk
    params.require(:bulk_meal).select{|mealtype| mealtype["meal_type"].present? and mealtype["time"].present?}.map do |mealtype| Mealtype.new(mealtype.permit(:meal_type, :time) )
    end
  end

  def home_index
    @mealtypes = Mealtype.all
  end
end
