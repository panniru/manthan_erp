class TeacherLeadersController < ApplicationController
 def create
   @teacher_leader = TeacherLeader.new(teacher_leader_params)
   if @teacher_leader.save
      flash[:success] = I18n.t :success, :scope => [:teacher_leader, :create]
     redirect_to teacher_leaders_path
    else
      render "new"
    end
  end
  
  def show
    @teacher_leader = TeacherLeader.find(params[:id])    
  end

  def index
    @teacher_leaders= TeacherLeader.all
    
  end
  
  def new
    @teacher_leader = TeacherLeader.new
  end
  
  def edit
    @teacher_leader = TeacherLeader.find(params[:id])
  end

  def update
    @teacher_leader = TeacherLeader.find(params[:id])
    if @teacher_leader.update(teacher_leader_params)
      flash[:success] = I18n.t :success, :scope => [:teacher_leader, :update]
      redirect_to teacher_leaders_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:teacher_leader, :update]
      render "edit"
    end
  end

  def destroy
    @teacher_leader = TeacherLeader.find(params[:id])    
    if @teacher_leader.destroy
      flash[:success] = I18n.t :success, :scope => [:teacher_leader, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:teacher_leader, :destroy]
    end
    redirect_to teacher_leaders_path
  end

  private
  def teacher_leader_params
    params.require(:teacher_leader).permit(:klass,:faculty_leader)
  end

end
