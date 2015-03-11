class DefaultMastersController < ApplicationController
    load_resource :only => [:show, :update, :edit, :destroy , :day_ends]
  
  def index
    respond_to do |format|
      format.json do
        @default_masters = DefaultMaster.all
        render :json => @default_masters 
      end
      format.html do
        render "index"
      end
    end
  end

  def day_ends
    @day_ends = DayEnd.all
    respond_to do |format|
      format.json do
        render :json => @day_ends
      end	
      format.html do
      end
    end
  end

  def days
    respond_to do |format|
      format.json do
        day_end_params = params[:day_ends]
        day_end = DayEnd.find(day_end_params["id"])
        day_end.transaction_date = day_end_params["transaction_date"]
        day_end.save
      end
      format.html do
      end
      render nothing: true
    end
  end

  def update
    respond_to do |format|
      format.json do
        render :json => @default_master.update(default_master_params)
      end
      format.html do
        if @default_master.update(default_master_params)
          flash[:success] = I18n.t :success, :scope => [:default_master, :update]
          redirect_to default_masters_path
        else
          flash.now[:fail] = I18n.t :fail, :scope => [:default_master, :update]
          render "edit"
        end
      end
    end
  end
  
  def destroy
    respond_to do |format|
      format.json do
        render :json => @default_master.destroy
      end
      format.html do
        if @default_master.destroy
          flash[:success] = I18n.t :success, :scope => [:default_master ,:destroy]
        else
          flash.now[:fail] = I18n.t :fail, :scope => [:default_master, :destroy]
        end
        redirect_to default_masters_path
      end
    end
  end

  def create
    respond_to do |format|
      @default_master = DefaultMaster.new(default_master_params)
      format.json do
        render :json => @default_master.save
      end
      format.html do
        if @default_master.save
          flash[:success] = I18n.t :success, :scope => [:default_master, :create]
          redirect_to default_masters_path
        else
          render "index"
        end
      end
    end
    
  end
  
  
  
  private
  
  def default_master_params
    params.require(:default_master).permit(:default_name, :default_desc, :default_value)
  end
  
end
