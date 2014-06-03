class StagesController < ApplicationController
  def create
    @stage = Stage.new(stage_params)
    if @stage.save
      flash.now[:success] = I18n.t :success, :scope => [:stage, :create]
      redirect_to stages_index_path
    else
      render "new"
    end
  end

  def index
    @stages = Stage.all
  end

  def new
    @stage = Stage.new
  end
  def show
    @stage = Stage.find(params[:id])
  end
  private
  def stage_params
    params.require(:stage).permit(:enquiry_submission, :application_issued, :application_submission, :assessment_scheduled, :assessment_completed, :management_review, :declaration)
    end
end
