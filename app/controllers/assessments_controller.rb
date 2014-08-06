class AssessmentsController < ApplicationController

  def index
    if current_user.admin?
      render "index"    
    elsif  current_user.teacher?
      render "teacher_index"
    end
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
       
        mappings.each do |t| 
         
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
  
  #ASSESSMENNT-GRADE-MAPPING
  def get_assessment_grade_mappings_service
    respond_to do |format|
      format.json do        
        assessment_mappings = AssessmentGradeMapping.all
        assessment_mappings = assessment_mappings.each.map do |mapping|
          {id: mapping.id, grade_master_id: mapping.grade_master_id, grade_name: mapping.grade_master.grade_name, assessment_type_id: mapping.assessment_type_id, assessment_type: mapping.assessment_type.assessment_type, no_of_times: mapping.no_of_times} 
        end
        render :json => assessment_mappings 
      end
    end
  end
  
  def save_assessment_grade_mappings
    respond_to do |format|
      format.json do            
        mappings = params[:mappings]
        
        AssessmentGradeMapping.where('assessment_type_id = '+"'#{mappings[0][:assessment_type_id]}'").map do |temp| 
          @value = "false"
          mappings.each do |t|           
            if temp.id == t['id']    
              @value = "true"
            end
          end
          if @value == "false"          
            AssessmentGradeMapping.find(temp.id).destroy          
          end
        end

        mappings.each do |t|         
          if t["id"].present?           
            @mapping = AssessmentGradeMapping.find(t["id"]) 
            @mapping.assessment_type_id = t['assessment_type_id']
            @mapping.grade_master_id = t['grade_master_id']
            @mapping.no_of_times = t['no_of_times'] 
            @mapping.save
          else
            @mapping = AssessmentGradeMapping.new(t)
            @mapping.save
          end
        end 
        render :json => true
      end
    end     
  end

  def get_teacher_assessments_service
    respond_to do |format|
      format.json do        
        teacher_assessments = AssessmentTeacherMapping.all
        teacher_assessments = teacher_assessments.each.map do |mapping|
          {id: mapping.id, faculty_master_id: mapping.faculty_master_id, faculty_name: mapping.faculty_master.faculty_name, grade_master_id: mapping.faculty_master_id,  grade_name: mapping.grade_master.grade_name, section_master_id: mapping.section_master_id,  section_name: mapping.section_master.section_name, assessment_type_id: mapping.assessment_type_id, assessment_type: mapping.assessment_type.assessment_type} 
        end
        render :json => teacher_assessments
      end
    end
  end
  
end
