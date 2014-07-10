class ParentsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy, :new, :new_upload]

  def new
    
  end

  def index
    page = params[:page].present? ? params[:page] : 1
    @parents = Parent.all.order("father_name").paginate(:page => page)
  end

  def create
    @parent = Parent.new(parent_params)
    if @parent.save
      flash.now[:success] = I18n.t :success, :scope => [:parent, :create]
      render "show"
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:parent, :create]
      render "new"
    end
  end

  def update
    if @parent.update(parent_update_params)
      flash.now[:success] = I18n.t :success, :scope => [:parent, :update]
      render "show"
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:parent, :update]
      render "edit"
    end
  end

  def destroy
    if @parent.destroy
      flash.now[:success] = I18n.t :success, :scope => [:parent, :destroy]
      redirect_to parents_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:parent, :destroy]
      render "show"
    end
  end

  def new_upload
    @parent_uploader = ParentUploader.new
    respond_to do |format|
      format.html { render "new_upload"}
      format.xls { send_data @parent_uploader.xls_template(col_sep: "\t") }
    end
  end

  def edit
    unless @parent.user.present?
      @parent.build_user
      @parent.user.role_id = Role.parent_role.id
    end
  end

  def upload
    @parent_uploader = ParentUploader.new(params[:parent_uploader])
    if @parent_uploader.save
      flash[:success] = I18n.t :success, :scope => [:parent, :upload]
      redirect_to parents_path
    else
      render "new_upload"
    end
  end


  private

  def parent_params
    params.require(:parent).permit(:name, :dob, :joining_date, :email, :course_id, :semester, :roll_number, :user_attributes => [:user_id, :email, :password, :password_confirmation, :role_id])
  end

  def parent_update_params
    params.require(:parent).permit(:name, :dob, :joining_date, :email, :course_id, :semester, :roll_number)
  end

end
