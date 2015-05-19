class StudentResultsController < ApplicationController
  def index
    @students =  StudentMaster.all
    @students = StudentMaster.new
  end

  def get_results
    respond_to do |format|
      format.json do       
        subjects_grades = GradeSection.all.map do |sg|
          {id: sg.id, grade_master_id: sg.grade_master_id, grade_name: sg.grade_master.grade_name, section_master_id: sg.section_master_id, section_name: sg.section_master.section_name, :union => sg.union } 
        end
        render :json => subjects_grades
      end
    end
  end    
  
  def get_users
    
    respond_to do |format|
      format.json  do
        p "111111111111"
        p params[:selected_user]
        # @students = StudentMaster.get_both(params[:selected_user])
        a = params[:selected_user].split('-')[0].to_i
        b = params[:selected_user].split('-')[1].to_i
        p "22222222"
        p a
        p b
        @student = StudentMaster.where(:grade_master_id=> a, :section_master_id=> b).map do |x|
        
          {student_master_id: x.id,student_name: x.name}
        end
        render :json => @student
      end
    end
  end

  def new
    @student = StudentMaster.new
  end

  def show
    # @student = StudentMaster.find(params[:id])
  end

end
