class ParentMastersController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy, :new, :new_upload]

  def new
  end

  def index
    page = params[:page].present? ? params[:page] : 1
    @parent_masters = ParentMaster.all.order("father_name").paginate(:page => page)
  end

  def destroy
    if @parent_master.destroy
      flash.now[:success] = I18n.t :success, :scope => [:parent_master, :destroy]
      redirect_to parent_masters_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:parent_master, :destroy]
      render "show"
    end
  end

  def new_upload
    @parent_master_uploader = ParentMasterUploader.new
    respond_to do |format|
      format.html { render "new_upload"}
      format.xls { send_data @parent_master_uploader.xls_template(col_sep: "\t") }
    end
  end

  def edit
    unless @parent_master.user.present?
      @parent_master.build_user
      @parent_master.user.role_id = Role.parent_master_role.id
    end
  end

  def upload
    @parent_master_uploader = ParentMasterUploader.new(params[:parent_master_uploader])
    if @parent_master_uploader.save
      flash[:success] = I18n.t :success, :scope => [:parent_master, :upload]
      redirect_to parent_masters_path
    else
      render "new_upload"
    end
  end

end
