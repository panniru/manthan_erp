class TaxBucketsController < ApplicationController
  def index
    @tax_buckets = TaxBucket.all
  end

  def new
    @tax_buckets = TaxBucket.new
  end

  def edit
    @tax_buckets = TaxBucket.find(params[:id])
  end
  
  def show
  end
  
  def update
    @tax_buckets =  TaxBucket.find(params[:id])
    if @tax_buckets.update(tax_bucket_params)
      flash[:success] = I18n.t :success, :scope => [:tax_bucket, :update]
      redirect_to tax_buckets_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:tax_bucket, :update]
      render  "edit"
    end
  end
  def create
    @tax_buckets = TaxBucket.new(tax_bucket_params)
    if @tax_buckets.save	
      flash.now[:success] = I18n.t :success, :scope => [:tax_bucket, :create]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:tax_bucket, :create]
    end
    redirect_to tax_buckets_path
  end

  private
  def tax_bucket_params
    params.require(:tax_bucket).permit(:from , :to , :tax )
  end
end
