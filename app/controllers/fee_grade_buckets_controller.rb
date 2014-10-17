class FeeGradeBucketsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  authorize_resource

  def index
    respond_to do |format|
      @fee_grade_buckets = FeeGradeBucket.paginate(:page => params[:page].present? ? params[:page] : 1)
      format.json do
        render :json => @fee_grade_buckets.map{ |bucket| FeeGradeBucketsDecorator.decorate(bucket).docorated_hash }
      end
      format.html do
        render "index"
      end
    end
    
  end
  
  def update
    respond_to do |format|
      format.json do
        render :json => @fee_grade_bucket.update(bucket_params)
      end
      format.html do
        if @fee_grade_bucket.update(bucket_params)
          flash[:success] = I18n.t :success, :scope => [:fee_grade_bucket, :update]
          redirect_to fee_grade_buckets_path
        else
          flash.now[:fail] = I18n.t :fail, :scope => [:fee_grade_bucket, :update]
          render "edit"
        end
      end
    end
    
  end

  def destroy
    respond_to do |format|
      format.json do
        render :json => @fee_grade_bucket.destroy
      end
      format.html do
        if @fee_grade_bucket.destroy
          flash[:success] = I18n.t :success, :scope => [:fee_grade_bucket, :destroy]
        else
          flash[:fail] = I18n.t :fail, :scope => [:fee_grade_bucket, :destroy]
        end
        redirect_to fee_grade_buckets_path
      end
    end
    
  end
  
  def show
     
  end
  
  def create
    respond_to do |format|
      @fee_grade_bucket = FeeGradeBucket.new(bucket_params)
      format.json do
        render :json => @fee_grade_bucket.save
      end
      format.html do
        if @fee_grade_bucket.save
          flash[:success] = I18n.t :success, :scope => [:fee_grade_bucket, :create]
          redirect_to fee_grade_buckets_path
        else
          render "index"
        end
      end
    end
    
  end
  def create_bulk
    respond_to do |format|
      @fee_grade_bucket_bulk = build_fee_grade_bucket_bulk
      format.json do
        status = nil
        status = (!@fee_grade_bucket_bulk.empty? and FeeGradeBucket.save_bulk(@fee_grade_bucket_bulk))
        render :json => status
      end
      format.html do
        if !@fee_grade_bucket_bulk.empty? and @fee_grade_bucket_bulk.map(&:valid?).all?
          @fee_grade_bucket_bulk.each(&:save!)
          GradeBucketMapping.generate_mapping
          flash[:success] = I18n.t :success, :scope => [:fee_grade_bucket, :create_bulk]
          redirect_to fee_grade_buckets_path
        else
          flash.now[:fail] = I18n.t :fail, :scope => [:fee_grade_bucket, :create_bulk]
          render "new"
        end
      end
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

  def destroy_all
    FeeGradeBucket.destroy_all
    redirect_to fee_grade_buckets_path
  end
  
  private

  def bucket_params
    params.require(:fee_grade_bucket).permit( :grade_from ,:grade_to)
  end
  
  def bucket_param_attributes(param)
    param.permit( :grade_from ,:grade_to)
  end
  
  def build_fee_grade_bucket_bulk
    params.require(:bulk_fee_grade_buckets).select{|fee_grade_bucket| fee_grade_bucket["grade_from"].present?  and fee_grade_bucket["grade_to"].present?}.map do |fee_grade_bucket|
      if fee_grade_bucket[:id].present?
        @fee_grade_bucket_obj = FeeGradeBucket.find(fee_grade_bucket[:id])
        fee_grade_bucket.each do |key, val|
          @fee_grade_bucket_obj.send(key+"=", val) if @fee_grade_bucket_obj.attributes.include?(key)
        end
        @fee_grade_bucket_obj
      else
        FeeGradeBucket.new(bucket_param_attributes(fee_grade_bucket))
      end
    end
  end
end

