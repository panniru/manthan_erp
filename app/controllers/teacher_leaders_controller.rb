class TeacherLeadersController < ApplicationController
 def create
   @teacher_leader = TeacherLeader.new(teacher_leader_params)
   if @teacher_leader.save
     redirect_to teacher_leaders_path
    else
      render "new"
    end
  end
  
  def show
    @teacher_leader = TeacherLeader.find(params[:id])    
  end

  def index
    @teacher_leaders= TeacherLeader.all.order('id ASC')
    
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
      redirect_to teacher_leaders_path
    else
      render "edit"
    end
  end

  def destroy
    @teacher_leader = TeacherLeader.find(params[:id])    
    @teacher_leader.destroy
    redirect_to teacher_leaders_path
  end

  private
  def teacher_leader_params
    params.require(:teacher_leader).permit(:klass,:faculty_leader)
  end

end
