class GradesSectionsMappingsController < ApplicationController

  def save_sections_mappings
    respond_to do |format|
      format.json do        
        mappings = params[:mappings]        
        SectionMaster.all.map do |temp| 
          @value = "false"
          mappings.each do |t|           
            if temp.id == t['id']         
              @value = "true"
            end
          end
          if @value == "false"          
            SectionMaster.find(temp.id).destroy          
          end
        end
        mappings.each do |t| 
          if t["id"].present?           
            @section_master =SectionMaster.find(t["id"])        
            @section_master.section_name = t['section_name']
            @section_master.grade_master_id = t['grade_master_id']
            @section_master.save
          else
            @section_master=SectionMaster.new(t)
            @section_master.save
          end
        end 
        render :json => true
      end
    end
  end
  
end
