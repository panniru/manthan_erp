class FeeTypesController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  
  def index
    @fee_types = FeeType.paginate(:page => params[:page].present? ? params[:page] : 1)
    respond_to do |format|
      format.json do
        render :json => @fee_types
      end
      format.html do
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        render :json => @fee_type.update(fee_type_params)
      end
    end
  end
  
  def destroy
    respond_to do |format|
      format.json do
        render :json => @fee_type.destroy
      end
    end
  end
  
  def edit
  end

  def new
  end
  
  def create_bulk
    @fee_type_bulk = build_fee_type_from_bulk
    respond_to do |format|
      format.json do
        fee_types_created = []
        if !@fee_type_bulk.empty? and @fee_type_bulk.map(&:valid?).all?
          @fee_type_bulk.each do |fee_type|
            if fee_type.save!
              fee_types_created << fee_type
            end
          end
        end
        render :json => fee_types_created
      end
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
