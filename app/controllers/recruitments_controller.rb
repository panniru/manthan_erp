class RecruitmentsController < ApplicationController
  def update
    @recruitment = Recruitment.find(params[:id])
    respond_to do |format|
      if @recruitment.update(recruitment_params)
        format.html { redirect_to staff_admissions_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recruitment.errors, :status => "failure" }
      end
    end
  end
  def update_close
    
    @recruitment = Recruitment.find(params[:id])
    @staff_admission = StaffAdmission.find(params[:id])
    respond_to do |format|
      if @recruitment.update(recruitment_params)
        @staff_admission.update(:status => "Form_Closed")
        format.html { redirect_to staff_admissions_path, notice: 'Form was successfully Closed.' }
        format.json { render action: 'index', :status => "success" }
        
      else
        format.html { render action: 'edit' }
        format.json { render json: @recruitment.errors, :status => "failure" }
      end
    end
  end

  def closed_forms
    @recruitments = Recruitment.closed_forms
  end
  def document_index
    @recruitments = Recruitment.document_verified
  end
  def assessment_index
    @recruitments =  Recruitment.where("status = 'Assessment_Planned'").order("staffhead")
  end
  def assessment_completed_index
    @recruitments =  Recruitment.assessment_completed
  end
  def management_index
    @recruitments=  Recruitment.management_review
  end
  def selected_staffs
    if params[:search].present?
      @recruitments =  Recruitment.search(params[:search])
    else
      @recruitments=  Recruitment.selected_staffs
      @staff_admissions = StaffAdmission.selected_staffs
    end
  end
   def sports_index
     @staff_admissions = StaffAdmission.all
     @recruitments = Recruitment.sports
   end
   
  def assessment_new
    @staff_admission = StaffAdmission.find(params[:id])
    @recruitment = Recruitment.new
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
  def document_verification
  
    @recruitment = Recruitment.find(params[:id])
    @staff_admission = StaffAdmission.find(params[:id])
  end
  def view_assessment
    
    @recruitment = Recruitment.find(params[:id])
    @staff_admission = StaffAdmission.find(params[:id])
  end
 
  def index
    @recruitments = Recruitment.all
  end
  
  def create
    @staff_admission = StaffAdmission.find(params[:staff_admission_id])
    @recruitment = @staff_admission.create_recruitment(params[:recruitment].permit(:id,:post,:staff_name,:description,:start_time,:end_time,:education_qualification,:educational_certificates,:previous_employment_proof,:salary_slips_for_previous_months, :title,:status,:staff_admission_id,:comments,:staffhead,:final_result, :form_no,:assessment_result,:closestatus))
  
    @staff_admission.status = params[:recruitment][:status]    
    @staff_admission.save
    respond_to do |format|
      if @recruitment.save 
        format.html { redirect_to staff_admissions_path, notice: 'Form was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end
  
  def new
    @staff_admission = StaffAdmission.find(params[:staff_admission_id])  
    @recruitment = @staff_admission.build_recruitment
  end
  
  def edit
    @recruitment = Recruitment.find(params[:id])
  end
  
  def show
    @recruitment = Recruitment.find(params[:id])
  end

  def update_rec
    
    @recruitment = Recruitment.find(params[:id])
    @staff_admission = StaffAdmission.find(params[:id])
    respond_to do |format|
      if @recruitment.update(recruitment_params)
        @staff_admission.update(:status => "Assessment_Planned")
        format.html { redirect_to staff_admissions_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
       
      else
        format.html { render action: 'edit' }
        format.json { render json: @recruitment.errors, :status => "failure" }
      end
    end
  end
  def update_ass
    
    @recruitment = Recruitment.find(params[:id])
    @staff_admission = StaffAdmission.find(params[:id])
    respond_to do |format|
      if @recruitment.update(recruitment_params)
        @staff_admission.update(:status => "Assessment_Completed")
        format.html { redirect_to staff_admissions_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
        
      else
        format.html { render action: 'edit' }
        format.json { render json: @recruitment.errors, :status => "failure" }
      end
    end
  end
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
  
 def destroy
   @recruitment = Recruitment.find(params[:id])
   @recruitment.destroy
   respond_to do |format|
     format.html { redirect_to recruitment_home_recruitments_path }
   end
 end
 def homeindex
   @recruitment = Recruitment.new
   @staff_admission = StaffAdmission.find(params[:id])
 end
 def assessment_result
   @recruitment = Recruitment.find(params[:id])
   @staff_admission = StaffAdmission.find(params[:id])
 end
 
 def recruitment_params
   params.require(:recruitment).permit(:post,:staff_name,:description,:start_time,:end_time,:education_qualification,:educational_certificates,:previous_employment_proof,:salary_slips_for_previous_months, :title,:status,:staff_admission_id,:id,:comments,:staffhead, :final_result,:form_no,:assessment_result,:closestatus)
 end
end
