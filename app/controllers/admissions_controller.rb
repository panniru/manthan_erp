class AdmissionsController < ApplicationController
  def index
    @events = Event.all
    @admissions = Admission.all
    @admissions = Admission.search(params[:search])
    
    
  end
  def admission_home
    @admissions = Admission.all
    
  end
  

  def show
    @event = Event.find(params[:id])
    @admission = Admission.find(params[:id])
    
  end

  def edit
    @event = Event.find(params[:id])
    @admission = Admission.find(params[:id])
  end

  def new
    @event = Event.new
    @admission = Admission.new
  end
  
  def create
    @admission = Admission.new(admission_params)
    @admission.update(:status => "Application Created")
    respond_to do |format|
      if @admission.save
        format.html { redirect_to admissions_path, notice: 'Enquiry was successfully created.' }
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
    @events = Event.all
  end
 def enquiry_index
   @admissions = Admission.all
   @admissions = Admission.search(params[:admission_no]).all
 end
 def admission_index
   @admissions = Admission.all
   @admissions = Admission.search(params[:search]).all
   
 end
 def enquiry_new
   @admission = Admission.new
 end
 def admission_new
   @admission = Admission.find(params[:id])

 end
 def admission_home
   @admissions = Admission.search(params[:search])
 end
 
 
 def update
   @admission = Admission.find(params[:id])
   respond_to do |format|
     if @admission.update(admission_params)
       @admission.update(:status => "Application Created")
       format.html { redirect_to admissions_path, notice: 'Admission was successfully updated.' }
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
  def admission_params
    params.require(:admission).permit(:admission_no,:branch,:surname,:second_lang,:board,:grade,:medium,:year,:written,:spoken,:reading,:blood_group,:allergy,:doctor_name,:doctor_mobile,:guardian_name,:guardian_mobile,:guardian_relationship,:from,:to,:avatar,:father_office_address,:mother_office_address,:father_office_telephone,:mother_office_telephone,:father_mobile,:mother_mobile,:father_religion,:mother_religion,:father_employer,:mother_employer,:father_email,:mother_email,:sib_name,:sib_age,:sib_sex,:sib_grade,:sib_school,:bus,:form_no, :middle_name,:name,:klass, :dob,:gender,:nationality,:language,:father_name,:mother_name,:father_occupation,:mother_occupation,:father_company,:mother_company,:father_education, :mother_education,:income,:address, :landline,:mobile,:email,:transport, :busstop,:last_school, :city, :changing_reason, :know_school,:person, :pp,:status)
  end
  def event_params
    params.require(:event).permit(:title, :description, :staff, :grade, :start_time, :end_time)
  end
end
