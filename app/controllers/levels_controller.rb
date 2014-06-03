class LevelsController < ApplicationController
  def create
    @level = Level.new(level_params)
    if @level.save
      flash[:success] = I18n.t :success, :scope => [:level, :create]
      redirect_to levels_path
    else
      render "new"
    end
  end

  def index
    @level = Level.all
  end

  def new
    @level = Level.new
    end
    def edit
    @level = Level.find(params[:id])
  end
  def update
    @level = Level.find(params[:id])
    if @level.update(level_params)
      flash[:success] = I18n.t :success, :scope => [:level, :update]
      redirect_to levels_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:level, :update]
      render "edit"
    end
  end

  def show
    
  end
  def destroy
    @level = Level.find(params[:id])    
    if @level.destroy
      flash[:success] = I18n.t :success, :scope => [:level, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:level, :destroy]
    end
    redirect_to levels_path
  end
  
  private

  def level_params
    params.require(:level).permit(:enquiry_submission, :application_issued, :application_submission, :assessment_scheduled, :assessment_completed, :management_review, :declaration)
  end
end
