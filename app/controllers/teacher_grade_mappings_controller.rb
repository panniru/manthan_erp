class TeacherGradeMappingsController < ApplicationController
  def check_teachers_grades_mapping  
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
        params[:_mappings].each do |t| 
          if t["id"].present?
            p t["id"]
            temp = TeacherGradeMapping.find(t["id"])
            temp.grade_master_id = t["grade_master_id"].to_i
            temp.section_master_id = t["section_master_id"].to_i
            temp.subject_master_id = t["subject_master_id"].to_i     
            temp.save
          else
            @timetable = TeacherGradeMapping.new(add_params(t))
            @timetable.save
          end
        end
        render :json => true
      end
    end
  end

  def getmappings   
    respond_to do |format|
      format.json do
        teachersgrademappings = TeacherGradeMapping.where('faculty_master_id = '+"'#{params[:my_Teacher]}'")   
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
  
  def deletemappings
    respond_to do |format|
      format.json do       
        if params[:_delete_mapping_id].present?
          TeacherGradeMapping.find(params[:_delete_mapping_id]).destroy      
        end
        render :json => true
      end
    end
  end

  def get_grade_wise_mappings    
    respond_to do |format|
      format.json do        
        my_Grade = params[:my_Grade]
        my_Section = params[:my_Section]

        if (params[:my_Section] == nil)         
            teachersgrademappings = TeacherGradeMapping.where('grade_master_id = '+"#{my_Grade}") 
        else
          teachersgrademappings = TeacherGradeMapping.where('grade_master_id = '+"#{my_Grade}"+" AND "+'section_master_id = '+"#{my_Section}")          
        end  
      
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
          {id: mapping.id,  grade_master_id: mapping.grade_master_id.to_i, grade_name: grad_name, section_master_id: mapping.section_master_id.to_i, section_name: sec_name, subject_master_id: mapping.subject_master_id.to_i ,subject_name: sub_name , faculty_master_id: mapping.faculty_master_id, faculty_name: mapping.faculty_master.faculty_name}
        end        
        render :json =>teachersgrademappings
        end
    end    
  end

  def add_params(params)
    params.permit(:id, :grade_master_id, :section_master_id , :subject_master_id, :faculty_master_id) 
  end
  
end
