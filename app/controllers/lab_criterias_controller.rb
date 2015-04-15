class LabCriteriasController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def edit
  end
  
  def get_lab_masters
    lab_masters = SubjectMaster.get_sub_type.map do |lab_master|
      {lab_name: lab_master.subject_name , id: lab_master.id }
    end
    render :json => lab_masters
  end
  def get_all_grades
    all_grades  = GradeMaster.all.map do |grade|
      {grade_name: grade.grade_name , grade_master_id: grade.id }
    end
    render :json => all_grades
  end
  
  def show
    all_grades  = GradeMaster.all.map do |grade|
      {grade_name: grade.grade_name , grade_master_id: grade.id }
    end
    render :json => all_grades
  end

  def save_assessment_criterias
    respond_to do |format|
      format.json do        
        criterias = params[:criterias]        
        criterias.each do |t|         
          @assessment_criteria=LabCriteria.new(lab_params(t))
          @assessment_criteria.save         
        end 
        render :json => true
      end
    end
  end
  
  def get_assessment_criteria
    respond_to do |format|
      format.json do       
        lab_assessments = LabCriteria.where('grade_master_id = '+"#{params[:lab_name]}")      
        p "1111111111111111111111"
        p lab_assessments
        lab_assessments = lab_assessments.each.map do |lab_assessment|
          {id: lab_assessment.id,  grade_master_id: lab_assessment.grade_master_id, lab_name: lab_assessment.subject_master.subject_name, lab_criteria: lab_assessment.lab_criteria} 
        end
        render :json => lab_assessments       
      end
    end
  end

  def deletemappings
    respond_to do |format|
      format.json do       
        if params[:delete_mapping_id].present?
          LabCriteria.find(params[:delete_mapping_id]).destroy 
        end
        render :json => true
      end
    end
  end


  def lab_params(params)
    params.permit(:grade_master_id , :subject_master_id ,  :lab_criteria)
  end

end
