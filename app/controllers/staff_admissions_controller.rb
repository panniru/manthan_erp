class StaffAdmissionsController < ApplicationController
  def update_man
    
    @recruitment = Recruitment.find(params[:id])
    @staff_admission = StaffAdmission.find(params[:id])
    respond_to do |format|
      if @recruitment.update(recruitment_params)
        @staff_admission.update(:status => "Management_Reviewed")
        format.html { redirect_to staff_admissions_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
        
      else
        format.html { render action: 'edit' }
        format.json { render json: @recruitment.errors, :status => "failure" }
      end
    end
  end

  def update_close
    
    @staff_admission = StaffAdmission.find(params[:id])
    respond_to do |format|
      if @staff_admission.update(staff_admission_params)
        format.html { redirect_to staff_admissions_path, notice: 'Form was successfully Closed' }
        format.json { render action: 'index', :status => "success" }
        
      else
        format.html { render action: 'edit' }
        format.json { render json: @recruitment.errors, :status => "failure" }
      end
    end
  end

  def update_admission
    @staff_admission = StaffAdmission.find(params[:id])
    respond_to do |format|
      if  @staff_admission.update(:status => "Form_Closed")
        format.json { render action: 'index', :status => "success" }
      else
        format.json { render json: @staff_admission.errors, :status => "failure" }
      end
    end
  end

  def enquiry_index
    if params[:search].present?
      @staff_admissions = StaffAdmission.search(params[:search])
    else
      @staff_admissions = StaffAdmission.enquiry_forms
    end
  end
  
  def get_head_view
    head = Staffadmin.all.map do |head|
      { head_name: head.head,dept: head.dept,id: head.id}
    end
    render :json => head
  end

  
  def get_post_view
    post = Add.all.map do |post|
      { post_name: post.title,id: post.id}
    end
    render :json => post
  end
  

  def get_subject_view
    subject = SubjectMaster.all.map do |subject|
      { subject_name: subject.subject_name, id: subject.id}
    end
    render :json => subject
  end

  def get_klass_view
    klass = TeacherLeader.all.map do |klass|
      { grade_name: klass.klass, id: klass.id }
    end
    render :json => klass
  end

  def create
    @staff_admission = StaffAdmission.new(staff_admission_params)
    
     respond_to do |format|
      if @staff_admission.save 
        format.html { redirect_to staff_admissions_path, notice: 'Form was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end
  
  def new
    @staff_admission = StaffAdmission.new
    
  end
  
  def index
    @staff_admissions = StaffAdmission.enquiry
  end

  def show
    @staff_admission = StaffAdmission.find(params[:id])
  end

  def edit
    @staff_admission = StaffAdmission.find(params[:id])
  end
  
  def update
    @staff_admission = StaffAdmission.find(params[:id])
    respond_to do |format|
      if @staff_admission.update(staff_admission_params)
        format.html { redirect_to recruitment_home_admissions_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
      else
        format.html { render action: 'edit' }
        format.json { render json: @staff_admission.errors, :status => "failure" }
      end
    end
  end
  def homeindex
    @recruitment = Recruitment.new
    @staff_admission = StaffAdmission.find(params[:id])
  end
 
  def staff_admission_params
    params.require(:staff_admission).permit(:form_no,:name,:dob,:gender,:email,:mobile_no,:address,:language,:experience,:klass,:subject,:education_qualification,:expected_salary,:nationality,:status,:post,:staffhead,:closestatus)
  end
  
end
