class FeeGradeBucketsController < ApplicationController
  def index
     @feegradebuckets = FeeGradeBucket.all
  end

  def show
  end
  
  def addnew
    @feegradebuckets = FeeGradeBucket.new
  end
  def create
    puts params
    @feegradebuckets = FeeGradeBucket.new(bucket_params)
    if @feegradebuckets.save
      flash.now[:success] = I18n.t :success, :scope => [:fee_grade_bucket, :create]
      redirect_to  fee_grade_buckets_new_path
      
    else
      render "addnew"
    end
  end

  def edit
  end

 
  def bucket_params
    params.require(:fee_grade_bucket).permit( :bucket_name)
  end
end

