class GradingDefaultsController < ApplicationController
  def create
    @grading_default = GradingDefault.new(grading_default_params)
    if @grading_default.save
      redirect_to grading_defaults_path
    else
      render "new"
    end
  end 
  
  def show
    @grading_default = GradingDefault.find(params[:id])    
  end

  def index
    @grading_defaults= GradingDefault.all
  end
  
  def new
    @grading_default = GradingDefault.new
  end
  
  def edit
    @grading_default = GradingDefault.find(params[:id])
  end

  def update
    @grading_default = GradingDefault.find(params[:id])
    if @grading_default.update(grading_default_params)
      redirect_to grading_defaults_path
    else
      render "edit"
    end
  end

  def destroy
    @grading_default = GradingDefault.find(params[:id])    
    @grading_default.destroy
    redirect_to grading_defaults_path
  end

  private
  def grading_default_params
    params.require(:grading_default).permit(:pass_text_1,:pass_text_2,:pass_text_3,:pass_text_4,:pass_text_5,:pass_text_6,:pass_criteria_1,:pass_criteria_2,:pass_criteria_3,:pass_criteria_4,:pass_criteria_5,:pass_criteria_6 )
  end

end
