class DiscountsController < ApplicationController
  def index
    @discount = Discount.paginate(:page => params[:page].present? ? params[:page] : 1)
  end

  def show
  end
 
  def create
    @discount = Discount.new(discount_params)
    if @discount.save
      flash[:success] = I18n.t :success, :scope => [:discount, :create]
      redirect_to discounts_path
      
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:discount, :create]
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end
  
  def update
    @discount = Discount.find(params[:id])
    if @discount.update(discount_params)
      flash[:success] = I18n.t :success, :scope => [:discount, :update]
      redirect_to discounts_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:discount, :update]
    end
  end

  def new
  end
  
  def discount_params
    params.require(:discount).permit(:discount_percent, :academic_year)
  end
  
end
