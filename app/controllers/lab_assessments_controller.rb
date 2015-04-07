class LabAssessmentsController < ApplicationController
  # def index
  #   if current_user.admin?
  #     render "index"
  #   elsif current_user.teacher?
  #     render "teachers_index"
  #   end
  # end

# def get_teacher_mappings     
#     respond_to do |format|
#       format.json do
#         teachersmappings = TeacherGradeMapping.where('faculty_master_id = '+"'#{current_user.faculty_master.id}'") 
#         teachersmappings = teachersmappings.all.map do |mapping|
#           if  (mapping.subject_master_id.present?)
#             sub_name = mapping.subject_master.subject_name
#           else
#             sub_name = nil
#           end
#           if  (mapping.grade_master_id.present?)
#             grad_name = mapping.grade_master.grade_name
#           else
#             grad_name = nil
#           end
#           if  (mapping.section_master_id.present?)
#             sec_name = mapping.section_master.section_name
#           else
#             sec_name = nil
#           end
#           {id: mapping.id,  grade_master_id: mapping.grade_master_id.to_i, grade_name: mapping.grade_master.grade_name, section_master_id: mapping.section_master_id.to_i, section_name: sec_name, subject_master_id: mapping.subject_master_id.to_i ,subject_name: sub_name }
#         end    
#         render :json => teachersmappings   
#       end
#     end
#   end

 def get_assessment_subjects
   respond_to do |format|
    format.json do       
      subjects_grades = SubjectGrade.all.map do |sg|
        {id: sg.id, grade_master_id: sg.grade_master_id, grade_name: sg.grade_master.grade_name, subject_master_id: sg.subject_master_id, subject_name: sg.subject_master.subject_name, :union => sg.union} 
      end
      render :json => subjects_grades
    end
  end
end    



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


  def get_subjects_service
    respond_to do |format|
      format.json do        
        assessments = LabSubjectAssessment.all
        assessment = assessments.each do |assessment_type|
          {id: assessment_type.id, assessment_name: assessment_type.assessment_name ,lab_assessment_id: assessment_type.lab_assessment_id , subject_master_id: assessment_type.subject_master_id} 
        end
        render :json => assessment 
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

  # def get_assessment_grade_mappings
  #   respond_to do |format|
  #     format.json do 
  #       assessment_grade_mappings = LabAssessmentGradeMapping.all.map do |mapping|
  #         {id: mapping.id, grade_master_id: mapping.grade_master_id, lab_assessment_id: mapping.lab_assessment_id, assessment_type: mapping.lab_assessment.assessment_type}
  #       end
  #       render :json => assessment_grade_mappings      
  #     end
  #   end
  # end
  def save_assessments
    respond_to do |format|
      format.json do 
        p "11111111"
        p params[:assessments]
        assessments = params[:assessments]        
        assessments.each do |t|
          if t["id"].present? 
            @mapping = LabSubjectAssessment.find(t["id"])   
            @mapping.assessment_name = t['assessment_name']
            @mapping.lab_assessment_id = t['lab_assessment_id']
            @mapping.subject_master_id = t['subject_master_id']
            @mapping.save
          else              
            @mapping = LabSubjectAssessment.new(add_assessments_params(t))
            @mapping.save
          end
        end
        render :json => true
      end
    end 
  end

  def add_assessments_params(params)   
    params.permit(:assessment_name, :lab_assessment_id, :subject_master_id)
  end

 def save_teacher_mappings   
    respond_to do |format|
      format.json do           
        mappings = params[:mappings]        
        mappings.each do |t|
          if t["id"].present? 
            @mapping = TeacherListing.find(t["id"])          
            t['faculty_master_id'] = current_user.faculty_master.id
            @mapping.grade_master_id = t['grade_master_id'] 
          
            @mapping.subject_master_id = t['subject_master_id']  
            @mapping.lab_assessment_id = t['lab_assessment_id']  
            @mapping.assessment_desc = t['assessment_desc']  
            @mapping.assessment_date = t['assessment_date'].to_date  
            @mapping.save
          else              
            t['faculty_master_id'] = current_user.faculty_master.id         
            @mapping = TeacherListing.new(add_teacher_params(t))
            @mapping.save
          end
        end       
        render :json => true
      end
    end     
  end

 def add_teacher_params(params)   
   params.permit(:faculty_master_id, :grade_master_id, :subject_master_id, :lab_assessment_id, :assessment_desc, :assessment_date)
 end
 
end
