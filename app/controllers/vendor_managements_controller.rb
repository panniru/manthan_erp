class VendorManagementsController < ApplicationController
  def index
    @vendor_managements =  VendorManagement.all
  end

  def new
  end

  def edit
    @vendor_management = VendorManagement.find(params[:id])
  end

  def get_vendor_view
    vendor = VendorCategory.all.map do |vendor|
      { vendor: vendor.vendor_category ,id: vendor.id}
    end
    render :json => vendor
  end

  def show
  end
  def create 
    @vendor_management = VendorManagement.new(vendor_params)
    if @vendor_management.save
      redirect_to  vendor_managements_path
    else
      render "new"
    end
  end

  def destroy
    @vendor_management = VendorManagement.find(params[:id])
    if @vendor_management.destroy
      flash[:success] = I18n.t :success, :scope => [:vendor_management ,:destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:vendor_management, :destroy]
    end
    redirect_to vendor_managements_path
  end

   def update
    @vendor_management = VendorManagement.find(params[:id])
    if @vendor_management.update(vendor_params)
      flash[:success] = I18n.t :success, :scope => [:vendor_management, :update]
      redirect_to vendor_managements_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:vendor_management, :update]
      render "edit"
    end
  end

  def vendor_params
    params.require(:vendor_management).permit(:vendor_category_id,:contact_name, :vendor_name,:vendor_phone, :vendor_address, :vendor_alternate_email, :vendor_email , :verdor_mobile)
  end

end
