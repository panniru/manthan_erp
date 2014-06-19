class AddsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
 def create
   @add = Add.new(add_params)
   if @add.save
     flash[:success] = I18n.t :success, :scope => [:add, :create]
     redirect_to adds_path
    else
      render "new"
    end
  end
  def show
    end
  def index
    @adds= Add.all
  end

  def new
    @add = Add.new
  end
  def edit
    @add = Add.find(params[:id])
  end
  def update
    @add = Add.find(params[:id])
    if @add.update(add_params)
      flash[:success] = I18n.t :success, :scope => [:add, :update]
      redirect_to adds_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:add, :update]
      render "edit"
    end
  end
  def destroy
    @add = Add.find(params[:id])    
    if @add.destroy
      flash[:success] = I18n.t :success, :scope => [:add, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:add, :destroy]
    end
    redirect_to adds_path
  end
  private

  def add_params
    params.require(:add).permit(:title, :date, :description)
  end
end
