class StaffrecruitsController < ApplicationController
  def update_admission
    @staffrecruit = Staffrecruit.find(params[:id])
    respond_to do |format|
      if  @staffrecruit.update(:status => "Form_Closed")
        format.json { render action: 'index', :status => "success" }
      else
        format.json { render json: @staffrecruit.errors, :status => "failure" }
      end
    end
  end

  def management_result
    @staffrecruit = Staffrecruit.find(params[:id])
  end

  def enquiry_index
    @staffrecruits = Staffrecruit.all
  end
  
  def update
    @staffrecruit = Staffrecruit.find(params[:id])
    respond_to do |format|
      if @staffrecruit.update!(staffrecruit_params)
        if @staffrecruit.final_result == "Selected"
          new_faculty_master = get_faculty_master(@staffrecruit)
          if new_faculty_master.valid?
            new_faculty_master.save!
          else
          end
        end
        format.html { redirect_to staffrecruits_path, notice: 'Form was successfully updated.' }
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
    end
  end
  def upload_document
    @staffrecruit = Staffrecruit.find(params[:id])
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
  end
  def view_assessment
    @staffrecruit = Staffrecruit.find(params[:id])
  end
 
  def index
    if params[:staff_admission_id].present?
      @staffrecruits = Staffrecruit.where(:staff_admission_id => params[:staff_admission_id])
    else
      @staffrecruits = Staffrecruit.application_forms
    end
  end
  def create
    @staffrecruit = Staffrecruit.new(staffrecruit_params)
    respond_to do |format|
      if @staffrecruit.save 
        format.html { redirect_to staffrecruits_path, notice: 'Form was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end
  def new
    @staffrecruit = Staffrecruit.new
  end
  
  def edit
    @staffrecruit = Staffrecruit.find(params[:id])
  end
  
  def show
    @staffrecruit = Staffrecruit.find(params[:id])
  end
  
  def destroy
    @staffrecruit = Staffrecruit.find(params[:id])
    @staffrecruit.destroy
    respond_to do |format|
      format.html { redirect_to staffrecruits_path }
    end
  end
 def homeindex
   @staffrecruit = Staffrecruit.find(params[:id])
   
 end
 def assessment_result
   @staffrecruit = Staffrecruit.find(params[:id])
   
 end
 
 def staffrecruit_params
   params.require(:staffrecruit).permit(:post,:description,:start_time,:end_time,:education_qualification,:educational_certificates,:previous_employment_proof,:salary_slips_for_previous_months, :title,:status,:staff_admission_id,:id,:comments,:staffhead, :final_result,:form_no,:assessment_result,:closestatus,:management_result,:faculty_name,:dob,:subject_master_id,:address,:gender,:email,:mobile_no,:nationality,:klass,:language,:subject,:experience,:expected_salary,:staff_leader_id,:user_id,:dept)
 end
 def get_faculty_master(staff_obj)
   FacultyMaster.new do |fm|
     #fm.id = staff_obj.id
     fm.dept = staff_obj.dept
     fm.faculty_name = staff_obj.faculty_name
     fm.post = staff_obj.post
     fm.description = staff_obj.description
     fm.start_time = staff_obj.start_time
     fm.end_time = staff_obj.end_time
     fm.education_qualification = staff_obj.education_qualification
     fm.educational_certificates = staff_obj.educational_certificates
     fm.previous_employment_proof = staff_obj.previous_employment_proof
     fm.salary_slips_for_previous_months = staff_obj.salary_slips_for_previous_months
     fm.title = staff_obj.title
     fm.status = staff_obj.status
     fm.staff_admission_id = staff_obj.staff_admission_id
     fm.comments = staff_obj.comments
     fm.staffhead = staff_obj.staffhead
     fm.final_result = staff_obj.final_result
     fm.form_no = staff_obj.form_no
     fm.assessment_result = staff_obj.assessment_result
     fm.management_result = staff_obj.management_result
     fm.closestatus = staff_obj.closestatus
     fm.dob = staff_obj.dob
     fm.subject_master_id = staff_obj.subject_master_id
     fm.address = staff_obj.address
     fm.gender = staff_obj.gender
     fm.email = staff_obj.email
     fm.mobile_no = staff_obj.mobile_no
     fm.nationality = staff_obj.nationality
     fm.klass = staff_obj.klass
     fm.language = staff_obj.language
     fm.subject = staff_obj.subject
     fm.experience = staff_obj.experience
     fm.expected_salary = staff_obj.expected_salary
     fm.staff_leader_id = staff_obj.staff_leader_id
     fm.user_id = staff_obj.user_id
   end 
 end
end
