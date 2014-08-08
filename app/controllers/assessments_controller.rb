class AssessmentsController < ApplicationController

  def index
    if current_user.admin?
      render "index"    
    elsif  current_user.teacher?
      render "teacher_index"
    end
  end

  def get_teacher_grade_mappings     
    respond_to do |format|
      format.json do
        teachersgrademappings = TeacherGradeMapping.where('faculty_master_id = '+"'#{current_user.faculty_master.id}'")   
        teachersgrademappings = teachersgrademappings.all.map do |mapping|
          if  (mapping.subject_master_id.present?)
            sub_name = mapping.subject_master.subject_name
          else
            sub_name = nil
          end
          if  (mapping.grade_master_id.present?)
            grad_name = mapping.grade_master.grade_name
          else
            grad_name = nil
          end
          if  (mapping.section_master_id.present?)
            sec_name = mapping.section_master.section_name
          else
            sec_name = nil
          end
          {id: mapping.id,  grade_master_id: mapping.grade_master_id.to_i, grade_name: mapping.grade_master.grade_name, section_master_id: mapping.section_master_id.to_i, section_name: sec_name, subject_master_id: mapping.subject_master_id.to_i ,subject_name: sub_name }
        end    
        render :json => teachersgrademappings   
      end
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
            @assessment_type = AssessmentType.new(add_assessment_type_params(t))
            @assessment_type.save
          end
        end 
        render :json => true
      end
    end     
  end

  def add_assessment_type_params(params)
    params.permit(:id, :assessment_type)
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
            @mapping = AssessmentGradeMapping.new(add_assessment_grade_mapping_params(t))
            @mapping.save
          end
        end 
        render :json => true
      end
    end     
  end

  def add_assessment_grade_mapping_params(params)
    params.permit(:id, :assessment_type_id, :grade_master_id, :no_of_times)
  end

  def get_teacher_assessments_service
    respond_to do |format|
      format.json do       
        teacher_assessments = AssessmentTeacherMapping.where('grade_master_id = '+"'#{params[:my_Grade]}'"+" AND "+'section_master_id = '+"'#{params[:my_Section]}'"+" AND "+'subject_master_id = '+"'#{params[:my_Subject]}'")       
        teacher_assessments = teacher_assessments.each.map do |mapping|
          {id: mapping.id, faculty_master_id: mapping.faculty_master_id, faculty_name: mapping.faculty_master.faculty_name, grade_master_id: mapping.grade_master_id,  grade_name: mapping.grade_master.grade_name, section_master_id: mapping.section_master_id,  section_name: mapping.section_master.section_name, subject_master_id: mapping.subject_master_id,  subject_name: mapping.subject_master.subject_name, assessment_type_id: mapping.assessment_type_id, assessment_type: mapping.assessment_type.assessment_type, assessment_desc: mapping.assessment_desc, assessment_date: mapping.assessment_date} 
        end
        render :json => teacher_assessments
      end
    end
  end

  def save_teacher_assessments   
    respond_to do |format|
      format.json do           
        mappings = params[:mappings]        
        mappings.each do |t|
          if t["id"].present? 
            @mapping = AssessmentTeacherMapping.find(t["id"])          
            t['faculty_master_id'] = current_user.faculty_master.id
            @mapping.grade_master_id = t['grade_master_id'] 
            @mapping.section_master_id = t['section_master_id']
            @mapping.subject_master_id = t['subject_master_id']  
            @mapping.assessment_type_id = t['assessment_type_id']  
            @mapping.assessment_desc = t['assessment_desc']  
            @mapping.assessment_date = t['assessment_date'].to_date  
            @mapping.save
          else              
            t['faculty_master_id'] = current_user.faculty_master.id         
            @mapping = AssessmentTeacherMapping.new(add_teacher_assessments_params(t))
            @mapping.save
          end
        end       
        render :json => true
      end
    end     
  end

  def delete_teacher_assessment_mappings
    respond_to do |format|
      format.json do       
        if params[:_delete_mapping_id].present?
          AssessmentTeacherMapping.find(params[:_delete_mapping_id]).destroy   
        end
        render :json => true
      end
    end
  end

  def add_teacher_assessments_params(params)   
    params.permit(:faculty_master_id, :grade_master_id, :section_master_id, :subject_master_id, :assessment_type_id, :assessment_desc, :assessment_date)
  end
  
end
