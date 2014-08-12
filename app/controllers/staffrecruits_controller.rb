class StaffrecruitsController < ApplicationController
  
  def management_result
    @staffrecruit = Staffrecruit.find(params[:id])
  end

  def enquiry_index
    @staffrecruits = Staffrecruit.all
  end
    
  def update
    @staffrecruit = Staffrecruit.find(params[:id])
    respond_to do |format|
      if @staffrecruit.update(staffrecruit_params)
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
    @staffrecruits = Staffrecruit.application_forms
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
   params.require(:staffrecruit).permit(:post,:description,:start_time,:end_time,:education_qualification,:educational_certificates,:previous_employment_proof,:salary_slips_for_previous_months, :title,:status,:staff_admission_id,:id,:comments,:staffhead, :final_result,:form_no,:assessment_result,:closestatus,:management_result,:name,:dob,:subject_master_id,:address,:gender,:email,:mobile_no,:nationality,:klass,:language,:subject,:experience,:expected_salary,:staff_leader_id)
 end
end
