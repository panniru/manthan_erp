class AssessmentCriteriasController < ApplicationController
  def get_assessment_criteria_service
    respond_to do |format|
      format.json do       
        subjects_assessments = AssessmentCriteria.where('grade_master_id = '+"#{params[:my_Grade]}")         

        subjects_assessments = subjects_assessments.each.map do |as_cr|
          {id: as_cr.id, subject_master_id: as_cr.subject_master_id, subject_name: as_cr.subject_master.subject_name, grade_master_id: as_cr.grade_master_id, grade_name: as_cr.grade_master.grade_name, subject_criteria: as_cr.subject_criteria} 
        end
        render :json => subjects_assessments       
      end
    end
  end

  def save_assessment_criterias
    respond_to do |format|
      format.json do        
        mappings = params[:mappings]        
        mappings.each do |t|         
          @assessment_criteria=AssessmentCriteria.new(add_params(t))
          @assessment_criteria.save         
        end 
        render :json => true
      end
    end
  end

  def deletemappings
    respond_to do |format|
      format.json do       
        if params[:_delete_mapping_id].present?
          AssessmentCriteria.find(params[:_delete_mapping_id]).destroy 
        end
        render :json => true
      end
    end
  end

  def add_params(params)   
    params.permit( :grade_master_id, :subject_master_id, :subject_criteria)
  end
  
end
