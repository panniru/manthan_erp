class ClassTeacherMappingsController < ApplicationController
  def get_grade_wise_mappings    
    respond_to do |format|
      format.json do
        p my_Grade = params[:my_Grade]
           
            teachersgrademappings = TeacherGradeMapping.where('grade_master_id = '+"#{my_Grade}")        
      
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
        p teachersgrademappings
      end
    end
  end



end
