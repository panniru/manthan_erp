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
    respond_to do |format|
      format.json do
        p params
        p "$$$$$$$$$$"
        params[:_mappings].each do |t| 
          if t["id"].present?
            p t["id"]
            temp = TeacherGradeMapping.find(t["id"])
            temp.grade_master_id = t["grade_master_id"].to_i
            temp.section_master_id = t["section_master_id"].to_i
            temp.subject_master_id = t["subject_master_id"].to_i       
            temp.save
          else
            @timetable = TeacherGradeMapping.new(t)
            @timetable.save
          end
        end
        render :json => true
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
      if  (mapping.subject_master_id.present?)
        sub_name = mapping.subject_master.subject
      else
        sub_name = nil
      end
      if  (mapping.grade_master_id.present?)
        grad_name = mapping.grade_master.grade_name
      else
        grad_name = nil
      end
      if  (mapping.section_master_id.present?)
        sec_name = mapping.section_master.section
      else
        sec_name = nil
      end
      {id: mapping.id,  grade_master_id: mapping.grade_master_id.to_i, grade_name: grad_name, section_master_id: mapping.section_master_id.to_i, section_name: sec_name, subject_master_id: mapping.subject_master_id.to_i ,subject_name: sub_name }
    end    
    render :json => teachersgrademappings
    p teachersgrademappings
    p "@@@@@@@@@@@"
  end

end
