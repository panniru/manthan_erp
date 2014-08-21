class AttendancesController < ApplicationController
  
  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      flash[:success] = I18n.t :success, :scope => [:attendance, :create]
      redirect_to attendances_path
    else
      render "new"
    end
  end
  
  def show
    @attendance = Attendance.find(params[:id])    
  end

  def index
    #@attendances = Attendance.all
    if current_user.teacher?
      
  end
  
  def new
    @attendance = Attendance.new
  end
  
  def edit
    @attendance = Attendance.find(params[:id])
  end

  def update
    @attendance = Attendance.find(params[:id])
    if @attendance.update(attendance_params)
      flash[:success] = I18n.t :success, :scope => [:attendance, :update]
      redirect_to attendances_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:attendance, :update]
      render "edit"
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id])    
    if @attendance.destroy
      flash[:success] = I18n.t :success, :scope => [:attendance, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:attendance, :destroy]
    end
    redirect_to attendances_path
  end

  private
  def attendance_params
    params.require(:attendance).permit(:dept,:head,:add_id,:title,:post_role)
  end
end
