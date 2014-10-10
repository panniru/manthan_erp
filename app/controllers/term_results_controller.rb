class TermResultsController < ApplicationController

  def index
    if current_user.admin?
      render "index"     
    elsif  current_user.teacher?
      @academic_terms = AcademicTerm.all  
      if(ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.faculty_master.id}").length != 0)
        render "class_teacher_index"
      else
        render "teacher_index"  
      end
    elsif  current_user.principal?  
      @academic_terms = AcademicTerm.all     
      render "principal_index"    
    end
  end

  def term_results_mail_to_teachers
    respond_to do |format|
      format.json do          
        faculty_emails = Array.new
        faculty_names = Array.new
        FacultyMaster.all.each do |faculty|         
          faculty_emails << faculty.email if faculty.email.present?
          faculty_names << faculty.faculty_name if faculty.email.present?
        end       
        emails_names = faculty_emails.zip(faculty_names)       
        emails_names.each do |mail_name|         
          TermResultsMailer.term_result_mail(params[:myMailSubject], params[:myMailMessage], [mail_name[0]], mail_name[1]).deliver
        end
           
        render :json=>true
      end
    end
  end

  def get_term_results
    respond_to do |format|
      format.json do       
        term_results = TermResult.where('academic_term_id = '+"'#{params[:academic_Term_Id]}'"+" AND "+'grade_master_id = '+"'#{params[:my_Grade]}'"+" AND "+'section_master_id = '+"'#{params[:my_Section]}'"+" AND "+'subject_master_id = '+"'#{params[:my_Subject]}'")
       
        term_results = term_results.each.map do |mapping|      
          {id: mapping.id, academic_term_id: mapping.academic_term_id , grade_master_id: mapping.grade_master_id, section_master_id: mapping.section_master_id, student_master_id: mapping.student_master_id, student_name: mapping.student_master.name, grading_master_id: mapping.grading_master_id, grading_name: mapping.grading_master.grading_name, assessment_criteria_id: mapping.assessment_criteria_id , subject_criteria: mapping.assessment_criteria.subject_criteria}
        end
        render :json => term_results
      end
    end
  end

  def get_student_details
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

  def get_subject_assessment_criteria
    respond_to do |format|
      format.json do   
        assessment_criteria = AssessmentCriteria.where('grade_master_id = '+"'#{params[:my_Grade]}'"+" AND "+'subject_master_id = '+"'#{params[:my_Subject]}'")       
        assessment_criteria = assessment_criteria.each.map do |mapping|
          {id: mapping.id, subject_master_id: mapping.subject_master_id, grade_master_id: mapping.grade_master_id, subject_criteria: mapping.subject_criteria}
        end
        render :json => assessment_criteria 
      end
    end
  end

  def save_term_results
    respond_to do |format|
      format.json do          
        term_results = params[:term_results]
        term_results.each do |t|         
          if t["id"].present?           
            @term_result = TermResult.find(t["id"]) 
            @term_result.academic_term_id = t['academic_term_id'] 
            @term_result.grade_master_id = t['grade_master_id'] 
            @term_result.section_master_id = t['section_master_id']   
            @term_result.subject_master_id = t['subject_master_id']
            @term_result.assessment_criteria_id = t['assessment_criteria_id']
            @term_result.grading_master_id = t['grading_master_id']
            @term_result.save
          else
            @term_result = TermResult.new(add_term_results_params(t))
            @term_result.save
          end
        end         
        render :json => true
      end
    end
  end
  
  def add_term_results_params(params)   
    params.permit(:academic_term_id, :grade_master_id, :section_master_id, :subject_master_id, :assessment_criteria_id, :grading_master_id)
  end

  def get_grades_sections
    respond_to do |format|
      format.json do
        sections = SectionMaster.get_sections_by_role(current_user)        
        render :json => sections
      end
    end  
  end  

  def get_grade_subjects
    respond_to do |format|
      format.json do         
        grade_subjects = GradeSubjectMapping.where('grade_master_id = '+"'#{params[:my_Grade]}'")       
        grade_subjects = grade_subjects.each.map do |mapping|
          {id: mapping.id, grade_master_id: mapping.grade_master_id, grade_name: mapping.grade_master.grade_name, subject_master_id: mapping.subject_master_id, subject_name: mapping.subject_master.subject_name }
        end
        render :json => grade_subjects
      end
    end
  end

  def get_student_term_results
    respond_to do |format|
      format.json do         
        term_results = TermResult.where('academic_term_id = '+"'#{params[:academic_Term_Id]}'"+" AND "+'student_master_id = '+"'#{params[:my_Student]}'"+" AND "+'grade_master_id = '+"'#{params[:my_Grade]}'"+" AND "+'section_master_id = '+"'#{params[:my_Section]}'")       
        term_results = term_results.each.map do |mapping|      
          {id: mapping.id, academic_term_id: mapping.academic_term_id , grade_master_id: mapping.grade_master_id, section_master_id: mapping.section_master_id, student_master_id: mapping.student_master_id, student_name: mapping.student_master.name, grading_master_id: mapping.grading_master_id, grading_name: mapping.grading_master.grading_name, assessment_criteria_id: mapping.assessment_criteria_id , subject_criteria: mapping.assessment_criteria.subject_criteria}
        end
        render :json => term_results
      end
    end
  end
  
end
