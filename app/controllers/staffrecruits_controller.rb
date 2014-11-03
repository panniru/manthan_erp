class StaffrecruitsController < ApplicationController
  
  def recruitment_home
    if current_user.admin?
      if params[:search].present?
        @staffrecruits = Staffrecruit.search(params[:search])
      else
        @staffrecruits = Staffrecruit.application_forms  
      end
    end
    if current_user.teacher?
      if params[:search].present?
        @staffrecruits = Staffrecruit.search(params[:search])
      else
        @staffrecruits = Staffrecruit.assessment_planned
      end
    end
    if current_user.principal?
      if params[:search].present?
        @staffrecruits = Staffrecruit.search(params[:search])
      else
        @staffrecruits = Staffrecruit.assessment_completed
      end
    end
  end
  
  def admin_management_index
    @staffrecruits = Staffrecruit.management_review
  end
  def assess_completed_index
    @staffrecruits = Staffrecruit.assessment_completed
  end
  def assess_index
    @staffrecruits = Staffrecruit.assessment_planned
  end

  def close_index
    @staffrecruit = Staffrecruit.find(params[:id])
  end
  

  def recruited_form
    @staffrecruit = Staffrecruit.find(params[:id])
  end

  def enquiry_show
    @staffrecruit = Staffrecruit.find(params[:id])
  end

  def update_admission
    @staffrecruit = Staffrecruit.find(params[:id])
    respond_to do |format|
      @staffrecruit.update(staffrecruit_params)
      format.html { 
        redirect_to staffrecruits_path
      }
    end
  end

  def management_result
    @staffrecruit = Staffrecruit.find(params[:id])
  end

  def enquiry_index
    @staffrecruits = Staffrecruit.application_created
  end
  
  def update
    p '2222222222222222222222'
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
        format.html { redirect_to recruitment_home_staffrecruits_path, notice: 'Form was successfully updated.' }
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
    p "111111111111111"
    respond_to do |format|
      format.json do
        if(Staffadmin.where('faculty_master_id = '+"#{current_user.faculty_master.id}").length != 0)
          pa = "#{current_user.faculty_master.id}"
          p pa
          a = Staffadmin.where(:faculty_master_id => pa).map{|staff| staff.role_id}
          b = "Assessment Planned"
          ass = Staffrecruit.where(:user_id => a , :status => b).each.map do |mapping|
            {id: mapping.id, faculty_name: mapping.faculty_name, form_no: mapping.form_no, status: mapping.status, assessment_result: mapping.assessment_result, comments: mapping.comments, post: mapping.post}
          end
          render :json => ass
          p ass
        end
      end
      format.html
      {}
    end
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
  def get_klass_view
    klass = TeacherLeader.all.map do |klass|
      { grade_name: klass.klass,faculty_name: klass.faculty_leader, id: klass.id}
    end
    render :json => klass
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

  def document_verification
    @staffrecruit = Staffrecruit.find(params[:id])
  end
  def view_assessment
    @staffrecruit = Staffrecruit.find(params[:id])
  end
  def get_assessment_staff
    respond_to do |format|
      format.json do
        if(Staffadmin.where('faculty_master_id = '+"#{current_user.faculty_master.id}").length != 0)
          pa = "#{current_user.faculty_master.id}"
          p pa
          a = Staffadmin.where(:faculty_master_id => pa).map{|staff| staff.role_id}
          b = "Assessment Planned"
          ass = Staffrecruit.where(:user_id => a , :status => b).each.map do |mapping|
            {id: mapping.id, faculty_name: mapping.faculty_name, form_no: mapping.form_no, status: mapping.status, assessment_result: mapping.assessment_result, comments: mapping.comments, post: mapping.post}
          end
        end
        render :json => ass
      end
    end
  end

  def get_staff_assessment
    respond_to do |format|
      format.json do
        @staffrecruits = Staffrecruit.assessment_completed
        render :json => @staffrecruits
      end
      format.html do 
        render "assessment_completed_index"
      end
    end
  end


  def index
    @staffrecruits = Staffrecruit.management_review
    respond_to do |format|
      format.json do
        @staffrecruits = Staffrecruit.management_review
        render :json => @staffrecruits
      end
      format.html do 
        render "index"
      end
    end
  
      
    if current_user.admin?
      if params[:staff_admission_id].present?
        @staffrecruits = Staffrecruit.where(:staff_admission_id => params[:staff_admission_id])
      else
        @staffrecruits = Staffrecruit.application_forms
      end
    end
      # @staffrecruits = Staffrecruit.application_forms
    #   respond_to do |format|
    #     format.json do
    #       @staffrecruits = Staffrecruit.management_review
    #       render :json => @staffrecruits
    #     end
    #     format.html do 
    #       render "index"
    #     end
    #   end
    # end
    
    if current_user.teacher?
      @staffrecruits = Staffrecruit.assessment_planned
      respond_to do |format|
        format.json do
          if(Staffadmin.where('faculty_master_id = '+"#{current_user.faculty_master.id}").length != 0)
            pa = "#{current_user.faculty_master.id}"
            p pa
            a = Staffadmin.where(:faculty_master_id => pa).map{|staff| staff.role_id}
            b = "Assessment Planned"
            ass = Staffrecruit.where(:user_id => a , :status => b).each.map do |mapping|
              {id: mapping.id, faculty_name: mapping.faculty_name, form_no: mapping.form_no, status: mapping.status, assessment_result: mapping.assessment_result, comments: mapping.comments, post: mapping.post}
            end
            render :json => ass
            p ass
          end
        end
        format.html{}
      end
    end
     #  @staffrecruits = Staffrecruit.assessment_planned
    #   respond_to do |format|
    #     format.json do
    #       @staffrecruits = Staffrecruit.assessment_planned
    #       render :json => @staffrecruits
    #     end
    #     format.html do 
    #       render "index"
    #     end
    #   end
    # end

    if current_user.principal?
      @staffrecruits = Staffrecruit.assessment_completed
    respond_to do |format|
      format.json do
          @staffrecruits = Staffrecruit.assessment_completed
        render :json => @staffrecruits
      end
      format.html do 
        render "index"
        end
      end
    end
  end
 
  
  def create
    @staffrecruit = Staffrecruit.new(staffrecruit_params)
    @staffrecruit.form_no = Staffrecruit.getno
    respond_to do |format|
      if @staffrecruit.save 
        format.html { redirect_to recruitment_home_staffrecruits_path, notice: 'Form was successfully created.' }
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
  
  def edit_enquiry
    @staffrecruit = Staffrecruit.find(params[:id])
  end
  
  def edit_document
    @staffrecruit = Staffrecruit.find(params[:id])
  end
  
  def edit_assessment
    @staffrecruit = Staffrecruit.find(params[:id])
  end

  def show
    @staffrecruit = Staffrecruit.find(params[:id])
  end
  
  def destroy
    @staffrecruit = Staffrecruit.find(params[:id])
    @staffrecruit.destroy
    respond_to do |format|
      format.html { redirect_to recruitment_home_staffrecruits_path }
    end
  end
 def homeindex
   @staffrecruit = Staffrecruit.find(params[:id])
   
 end
 def assessment_result
   @staffrecruit = Staffrecruit.find(params[:id])
   
 end
 
 def staffrecruit_params
   params.require(:staffrecruit).permit(:post,:description,:start_time,:end_time,:education_qualification,:educational_certificates,:previous_employment_proof,:salary_slips_for_previous_months, :title,:status,:staff_admission_id,:id,:comments,:staffhead, :final_result,:form_no,:assessment_result,:closestatus,:management_result,:faculty_name,:dob,:subject_master_id,:address,:gender,:email,:mobile_no,:nationality,:klass,:language,:subject,:experience,:expected_salary,:staff_leader_id,:user_id,:dept,:role_id)
 end
 def get_faculty_master(staff_obj)
   FacultyMaster.new do |fm|
     #fm.id = staff_obj.id
     fm.role_id = staff_obj.role_id
     fm.dept = staff_obj.dept
     fm.faculty_name = staff_obj.faculty_name
     fm.post = staff_obj.post
     fm.address = staff_obj.address
     fm.education_qualification = staff_obj.education_qualification
     fm.gender = staff_obj.gender
     fm.email = staff_obj.email
     fm.mobile_no = staff_obj.mobile_no
     fm.nationality = staff_obj.nationality
     fm.language = staff_obj.language
     fm.primary_subject = staff_obj.subject
     fm.past_experience = staff_obj.experience
     fm.user_id = staff_obj.user_id
   end 
 end
end
