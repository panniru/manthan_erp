class StaffadminsController < ApplicationController
  def get_role_and_head
    role = Staffadmin.all.map do |role|
      { role_name: role.dept, id: role.id, head: role.head ,role_id: role.role_id, faculty_master_id: role.faculty_master_id}
    end
    render :json => role
  end

  def get_faculty_names
    faculty = FacultyMaster.all.map do |faculty|
      {id: faculty.id, faculty_name: faculty.faculty_name, post: faculty.post, dept: faculty.dept}
    end
    render :json => faculty
  end
  
 
  def create
    @staffadmin = Staffadmin.new(staffadmin_params)
    if @staffadmin.save
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
      redirect_to staffadmins_path
    else
      render "edit"
    end
  end

  def destroy
    @staffadmin = Staffadmin.find(params[:id])    
    @staffadmin.destroy
    redirect_to staffadmins_path
  end

  private
  def staffadmin_params
    params.require(:staffadmin).permit(:dept,:head,:add_id,:title,:post_role, :faculty_master_id, :role_id)
  end

end
