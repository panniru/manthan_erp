class FeeGradeBucketsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
 
  def index
     @fee_grade_buckets = FeeGradeBucket.paginate(:page => params[:page].present? ? params[:page] : 1, :per_page =>10)
  end

  def update
    if @fee_grade_bucket.update(bucket_params)
      flash[:success] = I18n.t :success, :scope => [:fee_grade_bucket, :update]
      redirect_to fee_grade_buckets_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:fee_grade_bucket, :update]
      render "edit"
    end
  end

  def destroy
    if @fee_grade_bucket.destroy
      flash[:success] = I18n.t :success, :scope => [:fee_grade_bucket, :destroy]
    else
      flash[:fail] = I18n.t :fail, :scope => [:fee_grade_bucket, :destroy]
    end
    redirect_to fee_grade_buckets_path
  end
  
  def show
     
  end
 
  def create
    @fee_grade_buckets = FeeGradeBucket.new(bucket_params)
    if @fee_grade_buckets.save
      flash[:success] = I18n.t :success, :scope => [:fee_grade_bucket, :create]
      redirect_to fee_grade_buckets_path
      
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:fee_grade_bucket, :create]
      render "addnew"
    end
  end

  def edit
    
  end

  def new
     @fee_grade_buckets = FeeGradeBucket.new
  end
 
  def bucket_params
    params.require(:fee_grade_bucket).permit( :bucket_name)
  end
end
