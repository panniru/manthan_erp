class GuestManagementsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]  
  
  def index
    @guest_managements = GuestManagement.all
  end

  def show
  end

  def create 
    @guest_management = GuestManagement.new(guest_params)
    @guest_management.came_to_meet =  params[:faculty_name] 
    if @guest_management.save
      redirect_to  guest_managements_path
    else
      render "new"
    end
  end

  def edit
  end

  def new
  end
  
  def destroy
   if @guest_management.destroy
      flash[:success] = I18n.t :success, :scope => [:guest_management ,:destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:guest_management, :destroy]
    end
    redirect_to guest_managements_path
  end
  
  def update
    @guest_management = GuestManagement.find(params[:id])
    if @guest_management.update(guest_params)
      flash[:success] = I18n.t :success, :scope => [:guest_management, :update]
      redirect_to guest_managements_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:guest_management, :update]
      render "edit"
    end
  end


  def guest_params
    params.require(:guest_management).permit(:guest_name,:guest_phone,:guest_address,:guest_email,:purpose, :follow_up,:follow_up_date, :came_to_meet)
  end
  
end
