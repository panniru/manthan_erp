class SectionMastersController < ApplicationController
  before_action :load_grade_master, :only => [:index]
  
  def index
    respond_to do |format|
      format.json do
        render :json => @grade_master.section_masters.all
      end
    end
  end

  private
  
  def load_grade_master
    @grade_master = GradeMaster.find(params[:grade_master_id])
  end
end
