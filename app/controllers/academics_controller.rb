class AcademicsController < ApplicationController

  def get_grades
    respond_to do |format|
      format.json do
        grades = GradeMaster.get_grades_by_role(current_user)
        render :json => grades        
      end
    end  
  end
  
  def get_academics_subjects
    respond_to do |format|
      format.json do         
        @subject_masters = SubjectMaster.where(subject_type: "academics")
        render :json => @subject_masters
      end
    end
  end

  def get_sections_for_grade    
    grade_sections = GradeSection.where('grade_master_id = '+"'#{params[:my_Grade]}'")
    grade_sections = grade_sections.each.map do |grade_section|
      {id: grade_section.id, grade_master_id: grade_section.grade_master_id, section_master_id: grade_section.section_master_id, section_name: grade_section.section_master.section_name }
    end       
    render  :json => grade_sections
  end

  def get_academics_subjects_for_grade    
    grade_subjects = GradeSubjectMapping.where('grade_master_id = '+"'#{params[:my_Grade]}'")
    grade_subjects = grade_subjects.each.map do |grade_subject|
      if grade_subject.subject_master.subject_type == "academics"
        {id: grade_subject.id, grade_master_id: grade_subject.grade_master_id, subject_master_id: grade_subject.subject_master_id, subject_name: grade_subject.subject_master.subject_name }
      end    
    end
    render  :json => grade_subjects.compact
  end

end
