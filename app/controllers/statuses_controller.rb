class StatusesController < ApplicationController
  def index
    @status = Status.new
    @statuses = Status.all
  end

  def create
    @status = Status.new(status_params)
    respond_to do |format|
      if @status.save
        format.html { redirect_to statuses_path }
      end
    end
  end
  def edit
    @status = Status.find(params[:id])
  end
  def destroy
    @status = Status.find(params[:id])
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_path }
    end
  end
  
  def update
    @status = Status.find(params[:id])
    respond_to do |format|
      if @status.update(admission_params)
        format.html { redirect_to statuses_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
      else
        format.html { render action: 'edit' }
        format.json { render json: @status.errors, :status => "failure" }
      end
    end
  end
  def status_params
    params.require(:status).permit(:reason)
  end
end
