class GradesSectionsMappingsController < ApplicationController

  def get_grades_sections_service_view
    respond_to do |format|
      format.json do       
        grades_sections = GradeSection.all.map do |gs|
          {id: gs.id, section_master_id: gs.section_master_id, section_name: gs.section_master.section_name, grade_master_id: gs.grade_master_id, grade_name: gs.grade_master.grade_name} 
        end
        render :json => grades_sections
      end
    end
  end     

  def save_grades_mappings
    respond_to do |format|
      format.json do        
        mappings = params[:mappings]        
        GradeSection.all.map do |temp| 
          @value = "false"
          mappings.each do |t|           
            if temp.id == t['id']         
              @value = "true"
            end
          end
          if @value == "false"          
            GradeSection.find(temp.id).destroy          
          end
        end
        mappings.each do |t| 
          if t["id"].present?           
            @section_grade = GradeSection.find(t["id"]) 
            @section_grade.section_master_id = t['section_master_id']
            @section_grade.grade_master_id = t['grade_master_id']
            @section_grade.save
          else
            @section_grade=GradeSection.new(add_params(t))
            @section_grade.save
          end
        end 
        render :json => true
      end
    end
  end  
  
  def add_params(params)
    params.permit(:id, :section_master_id, :grade_master_id)
  end
  
end
