class NaAssessmentsController < ApplicationController

  def index
    if current_user.admin?
      render "index"    
    elsif  current_user.teacher?
      render "teacher_index"
    end
  end

  def get_non_assessments
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


  def get_non_academics_subjects_for_grade    
    grade_subjects = GradeSubjectMapping.where('grade_master_id = '+"'#{params[:my_Grade]}'")
    grade_subjects = grade_subjects.each.map do |grade_subject|
      if grade_subject.subject_master.subject_type == "non_academics"
        {id: grade_subject.id, grade_master_id: grade_subject.grade_master_id, subject_master_id: grade_subject.subject_master_id, subject_name: grade_subject.subject_master.subject_name }
      end    
    end
    render  :json => grade_subjects.compact
  end



  def get_non_assessment_mappings_service
    respond_to do |format|
      format.json do       
        assessments = Assessment.where(subject_master_id: params[:my_Subject]).all.map do |mapping|
          agm = AssessmentGradeMapping.find(mapping.assessment_grade_mapping_id)
          if agm.grade_master_id == params[:my_Grade].to_i
            {id: mapping.id, assessment_name: mapping.assessment_name, subject_master_id: mapping.subject_master_id, subject_name: mapping.subject_master.subject_name, grade_master_id: agm.grade_master_id, grade_name: agm.grade_master.grade_name, assessment_type_id: agm.assessment_type_id, assessment_type: agm.assessment_type.assessment_type}
          end
        end
        render :json => assessments
      end
    end
  end

  def get_na_assessment_criteria
    respond_to do |format|
      format.json do 
        assessment_criteria = AssessmentCriteria.where(assessment_id: "#{params[:assessment_id]}").all.map do |mapping|
          {id: mapping.id, assessment_id: mapping.assessment_id, assessment_criteria: mapping.assessment_criteria}
        end
        render :json => assessment_criteria
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






  def get_non_academics_subjects
    respond_to do |format|
      format.json do         
        @subject_masters = SubjectMaster.where(subject_type: "non_academics")
        render :json => @subject_masters
      end
    end

  end

  def get_na_assessment_grade_mappings
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
        p "111111111111111111111"
        p params[:assessments]        
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

  def get_na_assessments
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


end
