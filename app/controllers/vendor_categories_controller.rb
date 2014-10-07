class VendorCategoriesController < ApplicationController
  def index
    @vendor_category =  VendorCategory.all
  end

  def new
  end

  def edit
  end

  def show
  end
  
  def create 
    @vendor_category = VendorCategory.new(vendor_params)
    if @vendor_category.save
      redirect_to  vendor_categories_path
    else
      render "new"
    end
  end

  def destroy
    @vendor_category = VendorCategory.find(params[:id])
    if @vendor_category.destroy
      flash[:success] = I18n.t :success, :scope => [:vendor_category ,:destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:vendor_category, :destroy]
    end
    redirect_to vendor_categories_path
  end
  
  def vendor_params
    params.require(:vendor_category).permit(:vendor_category)
  end
end
