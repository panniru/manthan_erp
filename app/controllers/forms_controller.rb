class FormsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  def create
    @form = Form.new(form_params)
    if @form.save
      flash[:success] = I18n.t :success, :scope => [:form, :create]
      redirect_to forms_path
    else
      render "new"
    end
    end
  def index
    @forms = Form.all
  end

  def new
    @form = Form.new
  end
def edit
  @form = Form.find(params[:id])
  end
  def show
  end
  def update
    @form = Form.find(params[:id])
    if @form.update(form_params)
      flash[:success] = I18n.t :success, :scope => [:form, :update]
      redirect_to forms_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:form, :update]
      render "edit"
    end
    end
  def destroy
    @form = Form.find(params[:id])    
    if @form.destroy
      flash[:success] = I18n.t :success, :scope => [:form, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:form, :destroy]
    end
    redirect_to forms_path
    end
  private

  def form_params
    params.require(:form).permit(:name, :dob, :gender, :email, :mobile_no, :address, :klass, :language, :subject, :experience, :expected_salary, :education_qualification, :nationality)
  end
end
