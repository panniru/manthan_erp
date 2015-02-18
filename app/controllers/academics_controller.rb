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
end
