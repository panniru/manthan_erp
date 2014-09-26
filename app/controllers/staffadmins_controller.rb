class StaffadminsController < ApplicationController
  def get_role_and_head
    role = Staffadmin.all.map do |role|
      { role_name: role.dept, id: role.id, head: role.head}
    end
    render :json => role
  end

  def get_faculty_names
    faculty = FacultyMaster.all.map do |faculty|
      { faculty_name: faculty.faculty_name, post: faculty.post, dept: faculty.dept}
    end
    render :json => faculty
  end
  
 
  def create
    @staffadmin = Staffadmin.new(staffadmin_params)
    if @staffadmin.save
      flash[:success] = I18n.t :success, :scope => [:staffadmin, :create]
      redirect_to staffadmins_path
    else
      render "new"
    end
  end
  
  def show
    @staffadmin = Staffadmin.find(params[:id])    
  end

  def index
    @staffadmins= Staffadmin.all
  end
  
  def new
    @staffadmin = Staffadmin.new
  end
  
  def edit
    @staffadmin = Staffadmin.find(params[:id])
  end

  def update
    @staffadmin = Staffadmin.find(params[:id])
    if @staffadmin.update(staffadmin_params)
      flash[:success] = I18n.t :success, :scope => [:staffadmin, :update]
      redirect_to staffadmins_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:staffadmin, :update]
      render "edit"
    end
  end

  def destroy
    @staffadmin = Staffadmin.find(params[:id])    
    if @staffadmin.destroy
      flash[:success] = I18n.t :success, :scope => [:staffadmin, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:staffadmin, :destroy]
    end
    redirect_to staffadmins_path
  end

  private
  def staffadmin_params
    params.require(:staffadmin).permit(:dept,:head,:add_id,:title,:post_role)
  end

end
