class AssessmentCriteriasController < ApplicationController
  def get_assessment_criteria_service
    respond_to do |format|
      format.json do        
        p params
        p "~~~~~~~~~~~~~~>"
        subjects_assessments = AssessmentCriteria.where('grade_master_id = '+"#{params[:my_Grade]}") 
        p subjects_assessments
        p "~~~~~~~~~~~~~~>"

        subjects_assessments = subjects_assessments.each.map do |as_cr|
          {id: as_cr.id, subject_master_id: as_cr.subject_master_id, subject_name: as_cr.subject_master.subject_name, grade_master_id: as_cr.grade_master_id, grade_name: as_cr.grade_master.grade_name, subject_criteria: as_cr.subject_criteria} 
        end
        render :json => subjects_assessments
        p subjects_assessments
        p "~~~~~~~~~~~~~~>"
      end
    end
  end

  def save_assessment_criterias
    respond_to do |format|
      format.json do  
        p params 
        p "!!!!!!!!!!!!!!!=>"
        mappings = params[:mappings]        
        mappings.each do |t|         
          @assessment_criteria=AssessmentCriteria.new(t)
          @assessment_criteria.save
          p @assessment_criteria
          p "!!!!!!!!!!!!!!!=>"
        end 
        render :json => true
      end
    end
  end

  def deletemappings
    respond_to do |format|
      format.json do  
        p params
        p "@@@@@@@@@@@@@@@=>"
        if params[:_delete_mapping_id].present?
          AssessmentCriteria.find(params[:_delete_mapping_id]).destroy 
        end
        render :json => true
      end
    end
  end
  
end
