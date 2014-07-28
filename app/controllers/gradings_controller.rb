# -*- coding: iso-8859-1 -*-
class GradingsController < ApplicationController
  def get_grading_service_view
    respond_to do |format|
      format.json do        
       gradings = GradingMaster.all

        gradings = gradings.each.map do |grading|
          {id: grading.id, grading_name: grading.grading_name, grading_desc: grading.grading_desc} 
        end
        render :json => gradings       
      end
    end
  end

  def save_gradings_mappings
    respond_to do |format|
      format.json do            
        mappings = params[:mappings]       
        mappings.each do |t| 
          if t["id"].present?           
            @grading_master = GradingMaster.find(t["id"]) 
            @grading_master.grading_name = t['grading_name']
            @grading_master.grading_desc = t['grading_desc']
            @grading_master.save
          else
            @grading_master = GradingMaster.new(t)
            @grading_master.save
          end
        end 
        render :json => true
      end
    end     
  end

  def delete_grading_mappings
    respond_to do |format|
      format.json do       
        if params[:_delete_mapping_id].present?
          GradingMaster.find(params[:_delete_mapping_id]).destroy   
        end
        render :json => true
      end
    end
  end

end
