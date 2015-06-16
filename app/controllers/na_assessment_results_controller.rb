class NaAssessmentResultsController < ApplicationController
  def index
    if current_user.admin?
      render "index"     
    elsif  current_user.teacher?      
      if(ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.faculty_master.id}").length != 0)
        render "class_teacher_index"
      else
        render "teacher_index"
      end
    end
  end

  def get_non_teacher_assessments_service
    respond_to do |format|
      format.json do       
        assessments = AssessmentListing.where('faculty_master_id = '+"#{current_user.faculty_master.id}")
        assessments = assessments.each.map do |mapping|
          {id: mapping.id, faculty_master_id: mapping.faculty_master_id, grade_master_id: mapping.grade_master_id, grade_name: mapping.grade_master.grade_name, section_master_id: mapping.section_master_id, section_name: mapping.section_master.section_name, subject_master_id: mapping.subject_master_id, subject_name: mapping.subject_master.subject_name, assessment_id: mapping.assessment_id, assessment_name: mapping.assessment.assessment_name, assessment_desc: mapping.assessment_desc, assessment_date: mapping.assessment_date}
        end         
        render :json => assessments
      end
    end
  end

  def get_non_student_details_service
    respond_to do |format|
      format.json do   
        students = StudentMaster.where('grade_master_id = '+"'#{params[:my_Grade]}'"+" AND "+'section_master_id = '+"'#{params[:my_Section]}'")       
        students = students.each.map do |mapping|
          {id: mapping.id, student_name: mapping.name}
        end
        render :json => students
      end
    end
  end

  def save_non_assessment_results_service
    respond_to do |format|
      format.json do       
        mappings = params[:mappings]
        mappings.each do |t|         
          if t["id"].present?           
            @assessment_result = AssessmentResult.find(t["id"]) 
            @assessment_result.assessment_listing_id = t['assessment_listing_id'] 
            @assessment_result.student_master_id = t['student_master_id']   
            @assessment_result.grading_master_id = t['grading_master_id']   
            @assessment_result.assessment_result_desc = t['assessment_result_desc']   
            @assessment_result.result_type = 'non_academics'
            @assessment_result.save
          else
            @assessment_result = AssessmentResult.new(add_assessment_result_params(t))
            @assessment_result.result_type = 'non_academics'
            @assessment_result.save
          end
        end         
        render :json => true
      end
    end
  end

  def get_non_assessment_results_service
    respond_to do |format|
      format.json do       
        assessment_results = AssessmentResult.where('assessment_listing_id = '+"'#{params[:assessment_Listing_Id]}'").where(:result_type => 'non_academics')
        assessment_results = assessment_results.each.map do |mapping|      
          {id: mapping.id, assessment_listing_id: mapping.assessment_listing_id , grade_master_id: mapping.assessment_listing.grade_master_id, section_master_id: mapping.assessment_listing.section_master_id, student_master_id: mapping.student_master_id, student_name: mapping.student_master.name, grading_master_id: mapping.grading_master_id, grading_name: mapping.grading_master.grading_name, assessment_result_desc: mapping.assessment_result_desc, subject_name: mapping.assessment_listing.subject_master.subject_name, assessment_type: mapping.assessment_listing.assessment.assessment_grade_mapping.assessment_type.assessment_type}
        end
        render :json => assessment_results
      end
    end
  end
  
  def add_assessment_result_params(params)   
    params.permit(:assessment_listing_id, :student_master_id, :grading_master_id, :assessment_result_desc, :result_type)
  end
 
  def get_non_assessments_service
    respond_to do |format|
      format.json do  
        grade_section = ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.faculty_master.id}").map do |g_s|
          {grade_master_id: g_s.grade_master_id, section_master_id: g_s.section_master_id}
        end     
  
        assessments = AssessmentListing.where('grade_master_id = '+"'#{grade_section[0][:grade_master_id]}'"+" AND "+'section_master_id = '+"'#{grade_section[0][:section_master_id]}'") 
  
        assessments = assessments.each.map do |mapping|
          if (AssessmentResult.where('assessment_listing_id = '+"#{mapping.id}").length !=0 && mapping.assessment_date < Time.now.to_date)
            assessment_result_status = "Completed"
          elsif (mapping.assessment_date >= Time.now.to_date)
            assessment_result_status = "Planned"
          else
            assessment_result_status = "in progress"
          end         
          
          {id: mapping.id, faculty_master_id: mapping.faculty_master_id, grade_master_id: mapping.grade_master_id, grade_name: mapping.grade_master.grade_name, section_master_id: mapping.section_master_id, section_name: mapping.section_master.section_name, subject_master_id: mapping.subject_master_id, subject_name: mapping.subject_master.subject_name, assessment_type_id: mapping.assessment.assessment_grade_mapping.assessment_type_id, assessment_type: mapping.assessment.assessment_grade_mapping.assessment_type.assessment_type, assessment_desc: mapping.assessment_desc, assessment_date: mapping.assessment_date, assessment_result_status: assessment_result_status}
        end         
        render :json => assessments
      end
    end
  end

  def get_non_teacher_grade_mappings     
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
          en
d
          if  (mapping.section_master_id.present?)
            sec_name = mapping.section_master.section_name
          else
            sec_name = nil
          end
          {id: mapping.id,  grade_master_id: mapping.grade_master_id.to_i, grade_name: mapping.grade_master.grade_name, section_master_id: mapping.section_master_id.to_i, section_name: sec_name, subject_master_id: mapping.subject_master_id.to_i ,subject_name: sub_name}
        end    
        render :json => teachersgrademappings   
      end
    end
  end
  end
end
