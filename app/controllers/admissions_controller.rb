class AdmissionsController < ApplicationController
 

  def get_klass_view
    klass = TeacherLeader.all.map do |klass|
      { grade_name: klass.klass,faculty_name: klass.faculty_leader, id: klass.id}
    end
    render :json => klass
  end
  
  def index
    if params[:teacher_leader_id].present?
      @admissions = Admission.where(:teacher_leader_id => params[:teacher_leader_id])
    else
      @admissions = Admission.all
      #respond_to do |format|
      # format.html
      # format.json { render :json => @admission}
    end
  end
  
  def create
    @admission = Admission.new(admission_params)
    @admission.teacher_leader = TeacherLeader.where(:klass => admission_params[:grade]).first
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
  
  def new
    @admission = Admission.new
  end
  
  def edit
    @admission = Admission.find(params[:id])
  end
  
  def show
    @admissions = Admission.all
  end
  
  def admission_home
    if params[:search].present?
      @admissions = Admission.search(params[:search])
    else
      @admissions = Admission.enquiry_forms_or_application_forms  
    end
  end
  
  def home_index
    @admission = Admission.find(params[:id])
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
     if @admission.update!(admission_params)
       if @admission.finalresult == "Selected"
         new_student_master = get_student_master(@admission)
         if new_student_master.valid?
           new_student_master.save!
         else
         end
       end
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
 
 def admission_params
   params.require(:admission).permit(:admission_no,:branch,:surname,:second_lang,:board,:grade,:medium,:year,:written,:spoken,:reading,:blood_group,:allergy,:doctor_name,:doctor_mobile,:guardian_name,:guardian_mobile,:guardian_relationship,:from,:to,:avatar,:father_office_address,:mother_office_address,:father_office_telephone,:mother_office_telephone,:father_mobile,:mother_mobile,:father_religion,:mother_religion,:father_employer,:mother_employer,:father_email,:mother_email,:sib_name,:sib_age,:sib_sex,:sib_grade,:sib_school,:bus,:form_no, :middle_name,:name,:klass, :dob,:gender,:nationality,:language,:father_name,:mother_name,:father_occupation,:mother_occupation,:father_company,:mother_company,:father_education, :mother_education,:income,:address, :landline,:mobile,:email,:transport, :busstop,:last_school, :city, :changing_reason, :know_school,:person, :pp,:status,:closestatus,:title, :description, :staff, :grade, :start_time, :end_time, :grade_master_id,:teacher_leader_id,:faculty,:comment, :result,:teachercomment,:finalresult)
 end
 def get_student_master(staff_obj)
   StudentMaster.new do |fm|
     #fm.id = staff_obj.id
     fm.admission_no = staff_obj.admission_no
     fm.name = staff_obj.name
     fm.branch = staff_obj.branch
     fm.description = staff_obj.description
     fm.start_time = staff_obj.start_time
     fm.end_time = staff_obj.end_time
     fm.surname = staff_obj.surname
     fm.second_lang = staff_obj.second_lang
     fm.board = staff_obj.board
     fm.medium = staff_obj.medium
     fm.year = staff_obj.year
     fm.written = staff_obj.written
     fm.spoken = staff_obj.spoken
     fm.reading = staff_obj.reading
     fm.blood_group = staff_obj.blood_group
     fm.finalresult = staff_obj.finalresult
     #fm.form_no = staff_obj.form_no
     fm.guardian_relationship = staff_obj.guardian_relationship
     fm.guardian_name = staff_obj.guardian_name
     fm.closestatus = staff_obj.closestatus
     fm.dob = staff_obj.dob
     fm.address = staff_obj.address
     fm.gender = staff_obj.gender
     fm.email = staff_obj.email
     fm.mobile = staff_obj.mobile
     fm.nationality = staff_obj.nationality
     fm.klass = staff_obj.klass
     fm.language = staff_obj.language
     fm.allergy = staff_obj.allergy
     fm.doctor_name = staff_obj.doctor_name
     fm.doctor_mobile = staff_obj.doctor_mobile
     fm.from = staff_obj.from
     fm.to = staff_obj.to
     fm.father_name = staff_obj.father_name
     fm.mother_name = staff_obj.mother_name
     fm.income = staff_obj.income
     fm.landline = staff_obj.landline
     fm.transport = staff_obj.transport
     fm.busstop = staff_obj.busstop
     #fm.last_school = staff_obj.last_school
     fm.city = staff_obj.city
     fm.changing_reason = staff_obj.changing_reason
     fm.know_school = staff_obj.know_school
     fm.person = staff_obj.person
     fm.pp = staff_obj.pp
     fm.status = staff_obj.status
     fm.sib_name = staff_obj.sib_name
     fm.sib_age = staff_obj.sib_age
     fm.sib_sex = staff_obj.sib_sex
     fm.sib_grade = staff_obj.grade
     fm.sib_school = staff_obj.sib_school
   end 
 end
end
