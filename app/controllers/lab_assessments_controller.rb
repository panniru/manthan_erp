class LabAssessmentsController < ApplicationController
  def get_assessment_types_service
    respond_to do |format|
      format.json do        
        assessment_types = LabAssessment.all
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
        
        mappings.each do |t| 
          
          if t["id"].present?           
            @assessment_type = LabAssessment.find(t["id"]) 
            @assessment_type.assessment_type = t['assessment_type']           
            @assessment_type.save
          else
            @assessment_type = LabAssessment.new(add_assessment_type_params(t))
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
          LabAssessment.find(params[:_delete_mapping_id]).destroy
        end
        render :json => true
      end
    end
  end

  def add_assessment_type_params(params)
    params.permit(:id, :assessment_type)
  end
   # MAPPINGS
  def get_grade_mappings_service
    respond_to do |format|
      format.json do        
       
       
        assessment_mapping = LabAssessmentGradeMapping.all
        p "111111111"
        p assessment_mapping
        assessment_mappings = assessment_mapping.each.map do |mapping|
        
          {id: mapping.id, grade_master_id: mapping.grade_master_id, lab_assessment_id: mapping.lab_assessment_id, assessment_type: mapping.lab_assessment.assessment_type, no_of_times: mapping.no_of_times} 
        end
        render :json => assessment_mappings
      end
    end
  end

  def save_assessment_grade_mappings
    respond_to do |format|
      format.json do            
        mappings = params[:mappings]
        p "2322323232323"
        p mappings
        LabAssessmentGradeMapping.where('lab_assessment_id = '+"'#{mappings[0][:lab_assessment_id]}'").map do |temp| 
          @value = "false"
          mappings.each do |t|           
            if temp.id == t['id']    
              @value = "true"
            end
          end
          if @value == "false"          
            LabAssessmentGradeMapping.find(temp.id).destroy          
          end
        end

        mappings.each do |t|         
          if t["id"].present?           
            @mapping = LabAssessmentGradeMapping.find(t["id"]) 
            @mapping.lab_assessment_id = t['lab_assessment_id']
            @mapping.grade_master_id = t['grade_master_id']
            @mapping.no_of_times = t['no_of_times'] 
            @mapping.save
          else
            @mapping = LabAssessmentGradeMapping.new(add_assessment_grade_mapping_params(t))
            @mapping.save
          end
        end 
        render :json => true
      end
    end     
  end
  def add_assessment_grade_mapping_params(params)
    params.permit(:id, :lab_assessment_id, :grade_master_id, :no_of_times)
  end
  # show assessments
  # def get_sections_for_grade    
  #   grade_sections = GradeSection.where('grade_master_id = '+"'#{params[:my_Grade]}'")
  #   grade_sections = grade_sections.each.map do |grade_section|
  #     {id: grade_section.id, grade_master_id: grade_section.grade_master_id, section_master_id: grade_section.section_master_id, section_name: grade_section.section_master.section_name }
  #   end       
  #   render  :json => grade_sections
  # end
  # def add_params(params)
  #   params.permit(:academic_year, :grade_master_id, :section_master_id, :period_id, :mon_sub, :tue_sub, :wed_sub, :thu_sub, :fri_sub, :sat_sub, :sun_sub, :st_time, :end_time)
  # end

end

