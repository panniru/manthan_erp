class AssessmentsController < ApplicationController

  def raw(stringish)
    stringish.to_s.html_safe
  end

  def get_assessment_types_service
    respond_to do |format|
      format.json do        
        assessment_types = AssessmentType.all
        assessment_types = assessment_types.each.map do |assessment_type|
          {id: assessment_type.id, assessment_type: assessment_type.assessment_type} 
        end
        render :json => assessment_types 
      end
    end
  end

  def save_assessment_type_mappings
    respond_to do |format|
      format.json do            
        mappings = params[:mappings]
        p mappings
        p "==================>"
        mappings.each do |t| 
          p t["id"]
          p "==================>"
          if t["id"].present?           
            @assessment_type = AssessmentType.find(t["id"]) 
            @assessment_type.assessment_type = t['assessment_type']           
            @assessment_type.save
          else
            @assessment_type = AssessmentType.new(t)
            @assessment_type.save
          end
        end 
        render :json => true
      end
    end     
  end

  def delete_assessment_type_mappings
    respond_to do |format|
      format.json do       
        if params[:_delete_mapping_id].present?
          AssessmentType.find(params[:_delete_mapping_id]).destroy   
        end
        render :json => true
      end
    end
  end

  
end
