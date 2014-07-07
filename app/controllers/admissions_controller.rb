class AdmissionsController < ApplicationController
  def index
    if params[:search].present?
      @admissions = Admission.search(params[:search])
    else
      @admissions = Admission.all.order("status")
    end
  end
 

  def show
    @event = Event.find(params[:id])
    @admission = Admission.find(params[:id])
    
  end

  def edit
    @admission = Admission.find(params[:id])
  end
  def edit_application
    @admission = Admission.find(params[:id])
  end
  def new
    @event = Event.new
    @admission = Admission.new
  end
  
  def create
    @admission = Admission.new(admission_params)
    respond_to do |format|
      if @admission.save
        format.html { redirect_to admission_home_admissions_path, notice: 'Enquiry was successfully created.' }
        format.json { render action: 'enquiry_show', :status => "enquiry_created", location: @admission }
      else
        format.html { render action: 'new' }
        format.json { render json: @admission.errors, status: :unprocessable_entity }
      end
    end
  end
  def enquiry_show
    @admission = Admission.find(params[:id])
  end
  def admission_show
    @admission = Admission.find(params[:id])
  end
  def event_show
    @event = Event.find(params[:id])
  end
  def event_index
    @event = Event.find(params[:admission_id])
    @admissions = @event.admissions
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
 def enquiry_new
   @admission = Admission.new
 end
 def admission_new
   @admission = Admission.find(params[:id])
 end
 def assessment_new
   @event = Event.new
 end

 def admission_home
     
     if params[:search].present?
       @admissions = Admission.search(params[:search])
     else
       @admissions = Admission.enquiry_forms_or_application_forms  
     end
 end

 def closed_forms
   @admissions = Admission.closed_forms
 end

 def home_index
   @admission = Admission.find(params[:id])
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
       format.html { redirect_to admission_home_admissions_path, notice: 'Admission was successfully updated.' }
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
     if  @admission.update(:status => "Form_Closed")
       format.json { render action: 'index', :status => "success" }
     else
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
  def admission_params
    params.require(:admission).permit(:admission_no,:branch,:surname,:second_lang,:board,:grade,:medium,:year,:written,:spoken,:reading,:blood_group,:allergy,:doctor_name,:doctor_mobile,:guardian_name,:guardian_mobile,:guardian_relationship,:from,:to,:avatar,:father_office_address,:mother_office_address,:father_office_telephone,:mother_office_telephone,:father_mobile,:mother_mobile,:father_religion,:mother_religion,:father_employer,:mother_employer,:father_email,:mother_email,:sib_name,:sib_age,:sib_sex,:sib_grade,:sib_school,:bus,:form_no, :middle_name,:name,:klass, :dob,:gender,:nationality,:language,:father_name,:mother_name,:father_occupation,:mother_occupation,:father_company,:mother_company,:father_education, :mother_education,:income,:address, :landline,:mobile,:email,:transport, :busstop,:last_school, :city, :changing_reason, :know_school,:person, :pp,:status,:closestatus)
  end
  def event_params
    params.require(:event).permit(:title, :description, :staff, :grade, :start_time, :end_time)
  end
end
