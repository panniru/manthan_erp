class GradeMastersController < ApplicationController
  load_resource :only => [:sections]
  authorize_resource

  
  def index
    respond_to do |format|
      format.json do
        render :json => GradeMaster.all.map{|grade| {:id => grade.id, :grade_name => grade.grade_name}}
      end
    end
  end

  def sections
    respond_to do |format|
      format.json do
        render :json => {:sections => @grade_master.grade_sections.map{|section| {:id => section.section_master_id, :section_name => section.section_master.section_name}}}
      end
    end
  end
end
