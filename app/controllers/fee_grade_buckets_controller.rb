class FeeGradeBucketsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  def index
     @fee_grade_buckets = FeeGradeBucket.paginate(:page => params[:page].present? ? params[:page] : 1)
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
    @fee_grade_bucket = FeeGradeBucket.new(bucket_params)
    if @fee_grade_bucket.save
      flash[:success] = I18n.t :success, :scope => [:fee_grade_bucket, :create]
       redirect_to fee_grade_buckets_path
    else
      render "index"
    end
  end
  def create_bulk
    @fee_grade_bucket_bulk = build_fee_grade_bucket_bulk
    if !@fee_grade_bucket_bulk.empty? and @fee_grade_bucket_bulk.map(&:valid?).all?
      @fee_grade_bucket_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:fee_grade_bucket, :create_bulk]
      redirect_to fee_grade_buckets_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:fee_grade_bucket, :create_bulk]
      render "new"
    end
  end

  def edit
    
  end
  
  def new
     @fee_grade_buckets = FeeGradeBucket.new
  end

  def all_grades
    respond_to do |format|
      format.json do
        render :json => GradeMaster.all
      end
    end
  end
 
  private

  def bucket_params
    params.require(:fee_grade_bucket).permit( :grade_from ,:grade_to)
  end
  
   def build_fee_grade_bucket_bulk
    params.require(:bulk_fee_grade_buckets).select{|fee_grade_bucket| fee_grade_bucket["grade_from"].present?  and fee_grade_bucket["grade_to"].present?}.map do |fee_grade_bucket|
      FeeGradeBucket.new(fee_grade_bucket)
    end

  end
end

