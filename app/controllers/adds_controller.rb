class AddsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]

  def get_dept_view
    add = Role.all.map do |add|
      { role_name: add.role, code: add.code, description: add.description, id: add.id}
    end
    render :json => add
  end

  def create
    @add = Add.new(add_params)
    if @add.save
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
      redirect_to adds_path
    else
      render "edit"
    end
  end

  def destroy
    @add = Add.find(params[:id])    
    @add.destroy
    redirect_to adds_path
  end

  private
  def add_params
    params.require(:add).permit(:title, :date, :description, :status,:dept)
  end
end
