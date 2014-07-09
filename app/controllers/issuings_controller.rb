class IssuingsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  def create
    @issuing = Issuing.new(issuing_params)
    if @issuing.save
      flash[:success] = I18n.t :success, :scope => [:issuing, :create]
      redirect_to issuings_path
    else
      render "new"
    end
  end
  def show
    end
  def index
    @issuings = Issuing.all
   
  end

  def new
    @issuing = Issuing.new
  end
  def edit
    @issuing = Issuing.find(params[:id])
  end
  def update
    @issuing = Issuing.find(params[:id])
    if @issuing.update(issuing_params)
      flash[:success] = I18n.t :success, :scope => [:issuing, :update]
      redirect_to issuings_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:issuing, :update]
      render "edit"
    end
  end
  def destroy
    @issuing = Issuing.find(params[:id])    
    if @issuing.destroy
      flash[:success] = I18n.t :success, :scope => [:issuing, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:issuing, :destroy]
    end
    redirect_to issuings_path
  end
  private

  def issuing_params
    params.require(:issuing).permit(:name, :grade, :section)
  end
end
