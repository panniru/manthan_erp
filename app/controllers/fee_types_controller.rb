class FeeTypesController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  
  def index
    @fee_types = FeeType.paginate(:page => params[:page].present? ? params[:page] : 1)
  end

  def update
    if @fee_type.update(fee_type_params)
      flash[:success] = I18n.t :success, :scope => [:fee_type, :update]
      redirect_to fee_types_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:fee_type, :update]
      render "edit"
    end
  end
  
  def destroy
    if @fee_type.destroy
      flash.now[:success] = I18n.t :success, :scope => [:fee_type, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:fee_type, :destroy]
    end
    redirect_to fee_types_path
  end
  
  def edit
  end

  def new
  end
  
  def create_bulk
    @fee_type_bulk = build_fee_type_from_bulk
    if !@fee_type_bulk.empty? and @fee_type_bulk.map(&:valid?).all?
      @fee_type_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:fee_type, :create_bulk]
      redirect_to fee_types_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:fee_type, :create_bulk]
      render "new"
    end
  end
  
  private
  
  def fee_type_params
    params.require(:fee_type).permit(:fee_type)
  end
  
  def build_fee_type_from_bulk
    params.require(:bulk_fee_types).select{|fee_type| fee_type["fee_type"].present?}.map do |fee_type|
      FeeType.new(fee_type)
    end
  end
  
end
