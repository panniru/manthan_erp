class GradesSectionsMappingsController < ApplicationController

  def save_sections_mappings
    respond_to do |format|
      format.json do
        p params
        p "===========>"
        mappings = params[:mappings]
        p mappings
        p "===========>"

        params[:mappings].each do |t| 
          if t["id"].present?           
            temp=SectionMaster.find(t["id"])        
            temp.section_name = t['section_name']
            temp.grade_master_id = t['grade_master_id']
            temp.update
          else
            @sectionmaster=SectionMaster.new(t)
            @sectionmaster.save
          end
        end       
      end
    end
  end

end
