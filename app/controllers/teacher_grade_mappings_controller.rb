class TeacherGradeMappingsController < ApplicationController
  def check_teachers_grades_mapping
    #params[:my_Teacher]
    respond_to do |format|
      format.json do
        teachersgradesmappings = TeacherGradeMapping.where('faculty_master_id = '+"#{params[:my_Teacher]}").count 
        render :json => teachersgradesmappings
        p teachersgradesmappings
      end
    end  
  end

  def savemappings 
    p params
    p "$$$$$$$$$$"
    params[:_mappings].each do |t| 
      if t["id"].present?
        p t["id"]
        temp = TeacherGradeMapping.find(t["id"])
        temp.grade_master_id = t["grade_master_id"]
        temp.section_master_id = t["section_master_id"]
        temp.subject_master_id = t["subject_master_id"]       
        temp.save
      else
        @timetable = TeacherGradeMapping.new(t)
        @timetable.save
      end
    end
  end

  def getmappings 
    p teachersgrademappings = TeacherGradeMapping.all
    p "~~~~~~~~~~~~~~~"
    
    teachersgrademappings = TeacherGradeMapping.where('faculty_master_id = '+"'#{params[:my_Teacher]}'")
    p teachersgrademappings
    p "!!!!!!!!!!!!!!!"
    teachersgrademappings = teachersgrademappings.all.map do |mapping|
      {id: mapping.id,  grade_master_id: mapping.grade_master_id, grade_name: mapping.grade_master.grade_name, section_master_id: mapping. section_master_id, section_name: mapping.section_master.section, subject_master_id: mapping.subject_master_id ,subject_name: mapping.subject_master.subject }
    end    
    render :json => teachersgrademappings
    p teachersgrademappings
    p "@@@@@@@@@@@"
  end

end
