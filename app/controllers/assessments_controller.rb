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
        teacher_assessments = AssessmentListing.where('grade_master_id = '+"'#{params[:my_Grade]}'"+" AND "+'section_master_id = '+"'#{params[:my_Section]}'"+" AND "+'subject_master_id = '+"'#{params[:my_Subject]}'")       
        teacher_assessments = teacher_assessments.each.map do |mapping|
          {id: mapping.id, faculty_master_id: mapping.faculty_master_id, faculty_name: mapping.faculty_master.faculty_name, grade_master_id: mapping.grade_master_id,  grade_name: mapping.grade_master.grade_name, section_master_id: mapping.section_master_id,  section_name: mapping.section_master.section_name, subject_master_id: mapping.subject_master_id,  subject_name: mapping.subject_master.subject_name, assessment_id: mapping.assessment_id, assessment_name: mapping.assessment.assessment_name, assessment_desc: mapping.assessment_desc, assessment_date: mapping.assessment_date} 
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
            @mapping = AssessmentListing.find(t["id"])          
            t['faculty_master_id'] = current_user.faculty_master.id
            @mapping.grade_master_id = t['grade_master_id'] 
            @mapping.section_master_id = t['section_master_id']
            @mapping.subject_master_id = t['subject_master_id']  
            @mapping.assessment_id = t['assessment_id']  
            @mapping.assessment_desc = t['assessment_desc']  
            @mapping.assessment_date = t['assessment_date'].to_date  
            @mapping.save
          else              
            t['faculty_master_id'] = current_user.faculty_master.id         
            @mapping = AssessmentListing.new(add_teacher_assessments_params(t))
            @mapping.save
          end
        end       
        render :json => true
      end
    end     
  end

  def add_teacher_assessments_params(params)   
    params.permit(:faculty_master_id, :grade_master_id, :section_master_id, :subject_master_id, :assessment_id, :assessment_desc, :assessment_date)
  end

  def delete_teacher_assessment_mappings
    respond_to do |format|
      format.json do       
        if params[:_delete_mapping_id].present?
          AssessmentListing.find(params[:_delete_mapping_id]).destroy   
        end
        render :json => true
      end
    end
  end

  def get_assessment_mappings_service
    respond_to do |format|
      format.json do       
        assessments = AssessmentListing.where('grade_master_id = '+"'#{params[:my_Grade]}'"+" AND "+'section_master_id = '+"'#{params[:my_Section]}'")       
        assessments = assessments.each.map do |mapping|
          {id: mapping.id, faculty_master_id: mapping.faculty_master_id, faculty_name: mapping.faculty_master.faculty_name, grade_master_id: mapping.grade_master_id,  grade_name: mapping.grade_master.grade_name, section_master_id: mapping.section_master_id,  section_name: mapping.section_master.section_name, subject_master_id: mapping.subject_master_id,  subject_name: mapping.subject_master.subject_name, assessment_type_id: mapping.assessment_type_id, assessment_type: mapping.assessment_type.assessment_type, assessment_desc: mapping.assessment_desc, assessment_date: mapping.assessment_date} 
        end
        render :json => assessments       
      end
    end
  end

  def get_assessment_grade_mappings
    respond_to do |format|
      format.json do 
        assessment_grade_mappings = AssessmentGradeMapping.all.map do |mapping|
          {id: mapping.id, grade_master_id: mapping.grade_master_id, grade_name: mapping.grade_master.grade_name, assessment_type_id: mapping.assessment_type_id, assessment_type: mapping.assessment_type.assessment_type}
        end
        render :json => assessment_grade_mappings      
      end
    end
  end

  def save_assessments
    respond_to do |format|
      format.json do 
        assessments = params[:assessments]        
        assessments.each do |t|
          if t["id"].present? 
            @mapping = Assessment.find(t["id"])   
            @mapping.assessment_name = t['assessment_name']
            @mapping.assessment_grade_mapping_id = t['assessment_grade_mapping_id']
            @mapping.subject_master_id = t['subject_master_id']
            @mapping.save
          else              
            @mapping = Assessment.new(add_assessments_params(t))
            @mapping.save
          end
        end
        render :json => true
      end
    end 
  end

  def add_assessments_params(params)   
    params.permit(:assessment_name, :assessment_grade_mapping_id, :subject_master_id)
  end

  def get_assessments
    respond_to do |format|
      format.json do 
        assessments = Assessment.all.map do |mapping|
          agm = AssessmentGradeMapping.find(mapping.assessment_grade_mapping_id)
          {id: mapping.id, assessment_name: mapping.assessment_name, subject_master_id: mapping.subject_master_id, subject_name: mapping.subject_master.subject_name, grade_master_id: agm.grade_master_id, grade_name: agm.grade_master.grade_name, assessment_type_id: agm.assessment_type_id, assessment_type: agm.assessment_type.assessment_type}
        end
        render :json => assessments      
      end
    end    
  end

  def save_assessment_criteria
    respond_to do |format|
      format.json do 
        assessment_criteria = params[:criteria]        
        assessment_criteria.each do |t|
          @mapping = AssessmentCriteria.new(add_assessment_criteria(t))
          @mapping.assessment_id = t["assessment_id"]
          @mapping.assessment_criteria = t["assessment_criteria"]
          @mapping.save
        end

        render :json => true
      end
    end
  end

  def add_assessment_criteria(params)  
    params.permit(:assessment_id, :assessment_criteria)
  end

  def get_assessment_criteria
    respond_to do |format|
      format.json do 
        assessment_criteria = AssessmentCriteria.where(assessment_id: "#{params[:assessment_id]}").all.map do |mapping|
          {id: mapping.id, assessment_id: mapping.assessment_id, assessment_criteria: mapping.assessment_criteria}
        end
        render :json => assessment_criteria
      end
    end
  end

  def get_assessments_for_assessment_type
    respond_to do |format|
      format.json do 
        p params 
        p "===================>"
        p AssessmentGradeMapping.ids
        p "++++++++++++++++++++"
        assessment_grade_mapping_id = AssessmentGradeMapping.where(assessment_type_id: "#{params[:assessment_type_id]}",grade_master_id: "#{params[:grade_master_id]}").pluck(:id)[0]
        p assessment_grade_mapping_id
        p "===================>"
        assessments  = Assessment.where(assessment_grade_mapping_id: assessment_grade_mapping_id,subject_master_id: "#{params[:subject_master_id]}").select(:id,:assessment_grade_mapping_id,:assessment_name).map {|mapping| {id: mapping.id, assessment_name: mapping.assessment_name}}
        p assessments 
        p "====================>"
        render :json => assessments
      end
    end
  end
  
end
