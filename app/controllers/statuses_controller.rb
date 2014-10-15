class StatusesController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]

  def index   
    respond_to do |format|
      format.json do  
        if current_user.admin?
          @statuses = Status.all
          render :json => @statuses
        end
      end     
      format.html do
        render "index"
      end
    end   
  end 
  
  def create
    @status = Status.new(status_params)
    if @status.save
      redirect_to statuses_path
    else
      render "new"
    end
  end
 
  def show
    respond_to do |format|
      format.json do
        render :json => @status
      end
      format.html do
        render "show"
      end
    end
  end
  
  def new
    @status = Status.new
  end
  
  def edit
    @status = Status.find(params[:id])
  end

  def update
    @status = Status.find(params[:id])
    if @status.update(status_params)
      redirect_to statuses_path
    else
      render "edit"
    end
  end
  
  def destroy
    @status = Status.find(params[:id])    
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_path }
    end
  end
    
  private
  def status_params
    params.require(:status).permit(:reason)
  end
end
