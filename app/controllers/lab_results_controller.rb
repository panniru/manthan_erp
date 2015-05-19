class LabResultsController < ApplicationController
  def get_names
    respond_to do |format|
      format.json do       
        # students = StudentMaster.get_student_name(params[:grade_master_id])
        a = params[:grade_master_id]
        student = StudentMaster.where(:grade_master_id => a).map do|x|
          {student_id: x.id, student_name: x.name, grade_master_id: x.grade_master_id } 
        end
        render :json => student
      end
      format.html do
      end
    end
  end 
  def lab
    @lab_results = LabResult.all
  end
  def index
    @lab_results = LabResult.all
    #@lab_results = LabResult.new
    if current_user.admin?
      render "teacher_form"
    elsif current_user.teacher?
      render "index"
    end
  end
  def new
    @lab_result= LabResult.new
  end
  def create
    @lab_result = LabResult.new(result_params)
    respond_to do |format|
      if @lab_result.save
        format.html {
          redirect_to lab_results_path
        }
      else
        format.html{
          redirect_to lab_results_path
        }
      end
    end
  end

  def show
    @lab_result=LabResult.find(params[:id]) 
  end
  

  def save_all
    @new=LabResult.new
    @new.listing_id = params[:listing_id]
    @new.student_master_id = params[:student_master_id]
    @new.grading_master_id = params[:grading_master_id]
    @new.save
    render :json =>  true
  end
   
  def result_params
    params.permit(:student_master_id, :grading_master_id, :listing_id)
  end
end
