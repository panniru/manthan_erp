class ActivityTeachersMappingsController < ApplicationController
  def check_activity_teachers_mapping  
    respond_to do |format|
      format.json do
        activity_teachers_mappings = ActivityTeachersMapping.where('subject_master_id = '+"#{params[:myActivity]}").count 
        render :json => activity_teachers_mappings
      end
    end  
  end

  def savemappings 
    respond_to do |format|
      format.json do  
        t = params[:mappings]
        if t["id"].present?
          temp = ActivityTeachersMapping.find(t["id"])
          temp.subject_master_id = t["subject_master_id"]    
          temp.faculty_master_id = t["faculty_master_id"]     
          temp.save
        else
          temp = ActivityTeachersMapping.new(add_params(t))
          temp.save
        end
        render :json => true
      end
    end
  end

  def getmappings
    respond_to do |format|
      format.json do
        activityteachersmappings = ActivityTeachersMapping.where(subject_master_id: params[:my_Activity]).each.map do |mapping|
          {id: mapping.id,  subject_master_id: mapping.subject_master_id, subject_name: mapping.subject_master.subject_name, faculty_name: mapping.faculty_master.faculty_name}
        end    
        render :json => activityteachersmappings   
      end
    end
  end
  
  def deletemapping
    respond_to do |format|
      format.json do       
        if params[:delete_mapping_id].present?
          ActivityTeachersMapping.find(params[:delete_mapping_id]).destroy      
        end
        render :json => true
      end
    end
  end
  
  private  
  def add_params(params)
    params.permit(:subject_master_id, :faculty_master_id) 
  end  
  
end
