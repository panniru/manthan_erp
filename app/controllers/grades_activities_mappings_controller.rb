class GradesActivitiesMappingsController < ApplicationController
  def get_grade_activities
    respond_to do |format|
      format.json do       
        grades_activities = GradeActivityMapping.all.map do |ga|
          {id: ga.id, activity_master_id: ga.activity_master_id, activity_name: ga.activity_master.activity_name, grade_master_id: ga.grade_master_id, grade_name: ga.grade_master.grade_name} 
        end
        render :json => grades_activities
      end
    end
  end     

  def save_grade_activities_mappings
    respond_to do |format|
      format.json do  
        p params    
        p "=====================>"
        mappings = params[:mappings]        
        GradeActivityMapping.all.map do |temp| 
          @value = "false"
          mappings.each do |t|           
            if temp.id == t['id']         
              @value = "true"
            end
          end
          if @value == "false"          
            GradeActivityMapping.find(temp.id).destroy          
          end
        end
        mappings.each do |t| 
          if t["id"].present?           
            @activity_grade = GradeActivityMapping.find(t["id"]) 
            @activity_grade.activity_master_id = t['activity_master_id']
            @activity_grade.grade_master_id = t['grade_master_id']
            @activity_grade.save
          else
            @activity_grade=GradeActivityMapping.new(add_params(t))
            @activity_grade.save
          end
        end 
        render :json => true
      end
    end
  end  

  def get_activities
    respond_to do |format|
      format.json do
        get_activities = ActivityMaster.all.map do |activity|
          {activity_name: activity.activity_name, activity_master_id: activity.id}
        end
        render :json => get_activities
      end
    end  
  end   

  private
  
  def add_params(params)
    params.permit(:id, :activity_master_id, :grade_master_id)
  end

end
