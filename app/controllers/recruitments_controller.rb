class RecruitmentsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  def create
    @recruitment = Recruitment.new(recruitment_params)
    if @recruitment.save
      flash[:success] = I18n.t :success, :scope => [:recruitment, :create]
      redirect_to recruitments_path
    else
      render "new"
    end
  end
  def show
    end
  def index
    @recruitments = Recruitment.all
    @recruitments = Recruitment.search(params[:search])
  end

  def new
    @recruitment = Recruitment.new
  end
  def edit
    @recruitment = Recruitment.find(params[:id])
  end
  def update
    @recruitment = Recruitment.find(params[:id])
    if @recruitment.update(recruitment_params)
      flash[:success] = I18n.t :success, :scope => [:recruitment, :update]
      redirect_to recruitments_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:recruitment, :update]
      render "edit"
    end
  end
  def destroy
    @recruitment = Recruitment.find(params[:id])    
    if @recruitment.destroy
      flash[:success] = I18n.t :success, :scope => [:recruitment, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:recruitment, :destroy]
    end
    redirect_to recruitments_path
  end
  private

  def recruitment_params
    params.require(:recruitment).permit(:title, :education_details, :experience)
  end
end

