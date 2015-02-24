class GradesActivitiesMappingsController < ApplicationController
  def get_grade_activities
    respond_to do |format|
      format.json do       
        grades_activities = GradeSubjectMapping.all.map do |ga|
          {id: ga.id, activity_master_id: ga.subject_master_id, activity_name: ga.subject_master.subject_name, grade_master_id: ga.grade_master_id, grade_name: ga.grade_master.grade_name} 
        end
        render :json => grades_activities
      end
    end
  end     

  def save_grade_activities_mappings
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
          if @value == "false"  &&  temp.subject_master.subject_type == "non_academics"        
            GradeSubjectMapping.find(temp.id).destroy          
          end
        end
        mappings.each do |t| 
          if t["id"].present?           
            @activity_grade = GradeSubjectMapping.find(t["id"]) 
            @activity_grade.subject_master_id = t['subject_master_id']
            @activity_grade.grade_master_id = t['grade_master_id']
            @activity_grade.save
          else
            @activity_grade=GradeSubjectMapping.new(add_params(t))
            @activity_grade.save
          end
        end 
        render :json => true
      end
    end
  end  

  private
  
  def add_params(params)
    params.permit(:id, :subject_master_id, :grade_master_id)
  end

end
