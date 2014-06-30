class TeacherGradeMappingsController < ApplicationController
  def check_teachers_grades_mapping
    params[:my_Teacher]=2
    respond_to do |format|
      format.json do
        teachersgradesmappings = TeacherGradeMapping.where('faculty_master_id = '+"#{params[:my_Teacher]}").count 
        render :json => teachersgradesmappings
      end
    end  
  end
end
