class RecruitmentsController < ApplicationController
  def update
    @staffrecruit = Staffrecruit.find(params[:id])
    respond_to do |format|
      if @staffrecruit.update(recruitment_params)
        format.html { redirect_to recruitment_home_recruitments_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
      else
        format.html { render action: 'edit' }
        format.json { render json: @staffrecruit.errors, :status => "failure" }
      end
    end
  end
  def update_close
    
    @staffrecruit = Staffrecruit.find(params[:id])
    @staff_admission = StaffAdmission.find(params[:id])
    respond_to do |format|
      if @staffrecruit.update(recruitment_params)
        @staff_admission.update(:status => "Form_Closed")
        format.html { redirect_to recruitment_home_recruitments_path, notice: 'Form was successfully Closed.' }
        format.json { render action: 'index', :status => "success" }
        
      else
        format.html { render action: 'edit' }
        format.json { render json: @staffrecruit.errors, :status => "failure" }
      end
    end
  end

  def closed_forms
    @staffrecruits = Staffrecruit.closed_forms
  end
  def document_index
    @staffrecruits = Staffrecruit.document_verified
  end
  def assessment_index
    @staffrecruits =  Staffrecruit.where("status = 'Assessment_Planned'").order("staffhead")
  end
  def assessment_completed_index
    @staffrecruits =  Staffrecruit.assessment_completed
  end
  def management_index
    @staffrecruits=  Staffrecruit.management_review
  end
  def selected_staffs
    if params[:search].present?
      @staffrecruits =  Staffrecruit.search(params[:search])
    else
      @staffrecruits=  Staffrecruit.selected_staffs
      @staff_admissions = StaffAdmission.selected_staffs
    end
  end
   def sports_index
     @staff_admissions = StaffAdmission.all
     @staffrecruits = Staffrecruit.sports
   end
   
  def assessment_new
    @staff_admission = StaffAdmission.find(params[:id])
    @staffrecruit = Staffrecruit.new
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
  
    @staffrecruit = Staffrecruit.find(params[:id])
    @staff_admission = StaffAdmission.find(params[:id])
  end
  def view_assessment
    
    @staffrecruit = Staffrecruit.find(params[:id])
    @staff_admission = StaffAdmission.find(params[:id])
  end
 
  def index
    @staffrecruits = Staffrecruit.all
  end
  
  def create
    @staffrecruit = Staffrecruit.new(recruitment_params)
    
    respond_to do |format|
      if @staffrecruit.save 
        format.html { redirect_to recruitment_home_recruitments_path, notice: 'Form was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end
  
  def new
    @staffrecruit = Staffrecruit.new
    @staff_admissions = StaffAdmission.all
  end
  
  def edit
    @staffrecruit = Staffrecruit.find(params[:id])
  end
  
  def show
    @staffrecruit = Staffrecruit.find(params[:id])
  end

  def update_rec
    
    @staffrecruit = Staffrecruit.find(params[:id])
    @staff_admission = StaffAdmission.find(params[:id])
    respond_to do |format|
      if @staffrecruit.update(recruitment_params)
        @staff_admission.update(:status => "Assessment_Planned")
        format.html { redirect_to recruitment_home_recruitments_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
       
      else
        format.html { render action: 'edit' }
        format.json { render json: @staffrecruit.errors, :status => "failure" }
      end
    end
  end
  def update_ass
    
    @staffrecruit = Staffrecruit.find(params[:id])
    @staff_admission = StaffAdmission.find(params[:id])
    respond_to do |format|
      if @staffrecruit.update(recruitment_params)
        @staff_admission.update(:status => "Assessment_Completed")
        format.html { redirect_to recruitment_home_recruitments_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
        
      else
        format.html { render action: 'edit' }
        format.json { render json: @staffrecruit.errors, :status => "failure" }
      end
    end
  end
  def update_man
    
    @staffrecruit = Staffrecruit.find(params[:id])
    @staff_admission = StaffAdmission.find(params[:id])
    respond_to do |format|
      if @staffrecruit.update(recruitment_params)
        @staff_admission.update(:status => "Management_Reviewed")
        format.html { redirect_to recruitment_home_recruitments_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
        
      else
        format.html { render action: 'edit' }
        format.json { render json: @staffrecruit.errors, :status => "failure" }
      end
    end
  end
  
 def destroy
   @staffrecruit = Staffrecruit.find(params[:id])
   @staffrecruit.destroy
   respond_to do |format|
     format.html { redirect_to recruitment_home_recruitments_path }
   end
 end
 def homeindex
   @staffrecruit = Staffrecruit.new
   @staff_admission = StaffAdmission.find(params[:id])
 end
 def assessment_result
   @staffrecruit = Staffrecruit.find(params[:id])
   @staff_admission = StaffAdmission.find(params[:id])
 end
 
 def recruitment_params
   params.require(:staffrecruit).permit(:post,:description,:start_time,:end_time,:education_qualification,:educational_certificates,:previous_employment_proof,:salary_slips_for_previous_months, :title,:status,:staff_admission_id,:id,:comments,:staffhead, :final_result,:form_no,:assessment_result,:closestatus,:management_result,:name,:dob,:subject_master_id,:address,:gender,:email,:mobile_no,:nationality,:klass,:language,:subject,:experience,:expected_salary,:staff_leader_id)
 end
end
