class RecruitmentsController < ApplicationController
  
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

  def index
    @recruitments = Recruitment.all
  end
  
  def create
    @recruitment = Recruitment.new(recruitment_params)
    respond_to do |format|
      if @recruitment.save 
        format.html { redirect_to recruitment_home_recruitments_path, notice: 'Form was successfully created.' }
        
      else
        format.html { render action: 'new' }
        
      end
    end
  end
  
  def new
    @recruitment = Recruitment.new
  end
  
  def edit
    @recruitment = Recruitment.find(params[:id])
  end
  
  def show
    @recruitment = Recruitment.find(params[:id])
  end
  
  def recruitment_home
    if params[:search].present?
      @recruitments = Recruitment.search(params[:search])
    else
      @recruitments = Recruitment.application_forms  
    end
  end
  
  def homeindex
    @recruitment = Recruitment.find(params[:id])
  end
  
  def enquiry_new
    @admission = Admission.new
  end
  
  def admission_new
    @admission = Admission.find(params[:id])
  end
  
  def assessment_new
    @admission = Admission.find(params[:id])
  end
  
  def enquiry_index
    if params[:search].present?
      @admissions = Admission.search(params[:search])
    else
      @admissions = Admission.enquiry_forms
    end
  end
  
  def admission_index
    if params[:search].present?
      @admissions = Admission.search(params[:search])
    else
      @admissions = Admission.application_forms
    end
  end
  
  def assessment_index
    if params[:search].present?
      @admissions = Admission.search(params[:search])
    else
      @admissions = Admission.assessment_planned
    end
  end
  
  def management_index
    if params[:search].present?
      @admissions = Admission.search(params[:search])
    else
      @admissions = Admission.management_review
    end
  end
  
  def edit_application
    @admission = Admission.find(params[:id])
  end
  
  def edit_assessment
    @admission = Admission.find(params[:id])
  end

  def edit_assessment_result
    @admission = Admission.find(params[:id])
  end
  
  def enquiry_show
    @admission = Admission.find(params[:id])
  end
  
  def admission_show
    @admission = Admission.find(params[:id])
  end
  
  def assessment_show
    @admission = Admission.find(params[:id])
  end
  
  def assessment_completed
    
    if params[:search].present?
      @admissions = Admission.search(params[:search])
    else
      @admissions = Admission.assessment_completed
    end
  end
  
  def view_assessment
    @admission = Admission.find(params[:id])
  end

  def assessment_result
    @admission = Admission.find(params[:id])
  end

  def management_result
    @admission = Admission.find(params[:id])
  end

  def selected_students
    if params[:search].present?
      @admissions = Admission.search(params[:search])
    else
      @admissions = Admission.selected_students
    end
  end
  
  def closed_forms
    @admissions = Admission.closed_forms
  end
  
  def update_enquiry
    @admission = Admission.find(params[:id])
    respond_to do |format|
      if @admission.update(admission_params)
        format.html { redirect_to admission_home_admissions_path, notice: 'Admission was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admission.errors, :status => "failure" }
      end
    end
  end
  
 def update
   @admission = Admission.find(params[:id])
   respond_to do |format|
     if @admission.update(admission_params)
       format.html { redirect_to admission_home_admissions_path, notice: 'Form was successfully updated.' }
       format.json { render action: 'index', :status => "success" }
     else
       format.html { render action: 'edit' }
       format.json { render json: @admission.errors, :status => "failure" }
     end
   end
 end
 
 def update_admission
   @admission = Admission.find(params[:id])
   respond_to do |format|
     if  @admission.update(:status => "Form_Closed")
       format.json { render action: 'index', :status => "success" }
     else
       format.json { render json: @admission.errors, :status => "failure" }
     end
   end
 end
 
 def update_assessment
   @admission = Admission.find(params[:id])
   respond_to do |format|
     if @admission.update(admission_params)
       format.html { redirect_to admission_home_admissions_path, notice: 'Assessment Planned was successfully updated.' }
       format.json { render action: 'index', :status => "success" }
     else
       format.html { render action: 'edit' }
       format.json { render json: @admission.errors, :status => "failure" }
     end
   end
 end
 def destroy
   @admission = Admission.find(params[:id])
   @admission.destroy
   respond_to do |format|
     format.html { redirect_to admission_index_admissions_path }
   end
 end
 
 def recruitment_params
   params.require(:recruitment).permit(:form_no,:name,:dob,:gender,:email,:mobile_no,:address,:language,:experience,:klass,:subject,:educational_qualification,:expected_salary,:nationality,:post,:status,:staff_name,:description,:start_time,:end_time,:educational_qualification,:start_time,:end_time,:educational_certificates,:previous_employment_proof,:salary_slips_for_previous_months, :title)
 end
end

