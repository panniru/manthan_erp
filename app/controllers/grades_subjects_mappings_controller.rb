class GradesSubjectsMappingsController < ApplicationController

  def get_grades_subjects_service_view
    respond_to do |format|
      format.json do       
        grades_subjects = GradeSubjectMapping.all.map do |gs|
          {id: gs.id, subject_master_id: gs.subject_master_id, subject_name: gs.subject_master.subject_name, grade_master_id: gs.grade_master_id, grade_name: gs.grade_master.grade_name} 
        end
        render :json => grades_subjects
      end
    end
  end

  def save_subjects_mappings
    respond_to do |format|
      format.json do        
        mappings = params[:mappings]        
        GradeSubjectMapping.all.map do |temp| 
          @value = "false"
          mappings.each do |t|           
            if temp.id == t['id']         
              @value = "true"
            end
          end
          if @value == "false"          
            GradeSubjectMapping.find(temp.id).destroy          
          end
        end
        mappings.each do |t| 
          if t["id"].present?           
            @subject_master = GradeSubjectMapping.find(t["id"]) 
            @subject_master.subject_master_id = t['subject_master_id']
            @subject_master.grade_master_id = t['grade_master_id']
            @subject_master.save
          else
            @subject_master=GradeSubjectMapping.new(t)
            @subject_master.save
          end
        end 
        render :json => true
      end
    end
  end




end
