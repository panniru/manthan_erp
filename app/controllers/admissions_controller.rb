class AdmissionsController < ApplicationController

  #---------------------------Merging Holiday Calendar Details
  def holidaycalendardata
    respond_to do |format|
      format.json do
        holiday_calendar = Holidaycalendar.select(:holiday_date).distinct   
        holiday_calendar = holiday_calendar.map do |calendar|
          {start: calendar.holiday_date, end: calendar.holiday_date,title: "holiday", description: "holiday", url: "#", holiday_date: calendar.holiday_date}
        end
        render :json => holiday_calendar
      end
    end
  end

  def holiday_date
    respond_to do |format|
      format.json do
        holiday_date = Holidaycalendar.where("holiday_date = '#{params[:date]}'")
        holiday_date = holiday_date.map do |holiday|
          {id: holiday.holiday_date, description: holiday.description}
        end
        render :json => holiday_date
      end
    end
  end
  
  def holidaycalendar_params
    params.require(:holidaycalendar).permit(:holiday_date, :description) 
  end

  #--------------------------

  def admin_management_index
    if current_user.admin?
      respond_to do |format|
        format.json do
          b = "Management Reviewed"
            ass = Admission.where( :status => b).each.map do |mapping|
            {id: mapping.id, name: mapping.name,form_no: mapping.form_no, grade: mapping.grade_master.grade_name, status: mapping.status, comment: mapping.comment, teachercomment: mapping.teachercomment, finalresult: mapping.finalresult, school_house: mapping.school_house, all_sections: mapping.get_section_master}
            end
          render :json => ass
          p ass
        end
        format.html
        {}
      end
    else
      @admissions = Admission.management_review
    end
    
  end
  def assess_completed_index
    @admissions = Admission.assessment_completed
  end
  def assess_index
    @admissions = Admission.assessment_planned
  end
  def assessment_index
    if current_user.teacher?
    respond_to do |format|
      format.json do
          p current_user.faculty_master.id
        if(TeacherLeader.where('faculty_master_id = '+"#{current_user.faculty_master.id}").length != 0)
          pa = "#{current_user.faculty_master.id}"
          p pa
          a = TeacherLeader.where(:faculty_master_id => pa).map{|student| student.grade_master_id}
          b = "Assessment Planned"
          ass = Admission.where(:grade_master_id => a, :status => b).each.map do |mapping|
            {id: mapping.id, name: mapping.name,form_no: mapping.form_no, grade: mapping.grade_master.grade_name, status: mapping.status, comment: mapping.comment, teachercomment: mapping.teachercomment}
          end
          render :json => ass
          p ass
        end
      end
      format.html
      {}
    end
    else
      @admissions = Admission.assessment_planned
    end
  end
  
  

  def get_assessment_students
    respond_to do |format|
      format.json do
        if(TeacherLeader.where('faculty_master_id = '+"#{current_user.faculty_master.id}").length != 0)
          pa = "#{current_user.faculty_master.id}"
          a = TeacherLeader.where(:faculty_master_id => pa).map{|student| student.grade_master_id}
          b = "Assessment Planned"
          ass = Admission.where(:grade_master_id => a, :status => b).each.map do |mapping|
            {id: mapping.id, name: mapping.name,form_no: mapping.form_no, grade: mapping.grade_master.grade_name, status: mapping.status, comment: mapping.comment, teachercomment: mapping.teachercomment}
          end
        end
          render :json => ass
      end
    end
  end

  def get_close_status
    reasons = Status.all.map do |reason|
      { reason: reason.reason, id: reason.id}
    end
    render :json => reasons
  end

 
  def get_klass_view
    klass = TeacherLeader.all.map do |klass|
      { grade_name: klass.klass,faculty_name: klass.faculty_leader, id: klass.id}
    end
    render :json => klass
  end
  
  def index
    if current_user.admin?
      respond_to do |format|
        format.json do
          b = "Management Reviewed"
          ass = Admission.where( :status => b).each.map do |mapping|
            {id: mapping.id, name: mapping.name,form_no: mapping.form_no, grade: mapping.grade_master.grade_name, status: mapping.status, comment: mapping.comment, teachercomment: mapping.teachercomment, finalresult: mapping.finalresult, school_house: mapping.school_house,all_sections: mapping.get_section_master, section_master_id: mapping.section_master_id}
           
          end
          render :json => ass
          p ass
        end
        format.html
        {}
      end
    else
      @admissions = Admission.management_review
    end
    # if current_user.admin?
    #   if params[:teacher_leader_id].present?
    #     @admissions = Admission.where(:teacher_leader_id => params[:teacher_leader_id])
    #   else
    #     @admissions = Admission.enquiry_forms_or_application_forms  
    #   end
    # end
      # @admissions = Admission.enquiry_forms_or_application_forms
    #   if Admission.where(:status => "Assessment Planned")
    #     @admissions = Admission.assessment_planned
    #     respond_to do |format|
    #       format.json do
    #         @admissions = Admission.assessment_planned
    #         render :json => @admissions
    #       end
    #       format.html do 
    #         render "admission_home"
    #       end
    #     end
    #   end
    #   if Admission.where(:status => 'Management Reviewed')
    #     @admissions = Admission.management_review
    #   end
    # end
    if current_user.teacher?
      respond_to do |format|
        format.json do
          if(TeacherLeader.where('faculty_master_id = '+"#{current_user.faculty_master.id}").length != 0)
            pa = "#{current_user.faculty_master.id}"
            a = TeacherLeader.where(:faculty_master_id => pa).map{|student| student.grade_master_id}
            b = "Assessment Planned"
            ass = Admission.where(:grade_master_id => a, :status => b).each.map do |mapping|
              {id: mapping.id, name: mapping.name,form_no: mapping.form_no, grade: mapping.grade_master.grade_name, status: mapping.status, comment: mapping.comment, teachercomment: mapping.teachercomment}
            end
            render :json => ass
            p ass
          end
        end
        format.html
        {}
      end
    end
  
    
    if current_user.principal?
      @admissions = Admission.assessment_completed
      respond_to do |format|
        format.json do
          @admissions = Admission.assessment_completed
          render :json => @admissions
        end
        format.html do
          render "admission_home"
        end
      end
    end
  end

          
  def create
    @admission = Admission.new(admission_params)
    @admission.form_no = Admission.get_no
    @admission.admission_no = Admission.get_no
    @admission.teacher_leader = TeacherLeader.where(:klass => admission_params[:grade]).first
    respond_to do |format|
      if @admission.save 
        format.html { redirect_to admission_home_admissions_path, notice: 'Enquiry was successfully created.' }
       
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
    if current_user.admin?
      if params[:search].present?
        @admissions = Admission.search(params[:search])
      else
        @admissions = Admission.enquiry_forms_or_application_forms  
      end
    end
   if current_user.teacher?
     if params[:search].present?
       @admissions = Admission.search(params[:search])
     else
       @admissions = Admission.assessment_planned
     end
   end
    if current_user.principal?
      if params[:search].present?
        @admissions = Admission.search(params[:search])
      else
        @admissions = Admission.assessment_completed
      end
    end
  end
  
  def home_index
    @admission = Admission.find(params[:id])
  end

  def close_index
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
        format.html { redirect_to admission_home_admissions_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admission.errors, :status => "failure" }
      end
    end
  end
  
 def update
   p "-======================="
   @admission = Admission.find(params[:id])
   # @admission.from = Admission.get_date
   # @test = Admission.get_date
   # p @test
   respond_to do |format|
     if @admission.update!(admission_params)
       if @admission.finalresult == "Selected"
         new_student_master = get_student_master(@admission)
         if new_student_master.valid?
           new_student_master.save!
         else
         end
         new_parent_master = get_parent_master(@admission)
         if new_parent_master.valid?
           new_parent_master.save!
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
     if  @admission.update(:status => "Form Closed")
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
       format.html { redirect_to admission_home_admissions_path, notice: 'Form was successfully updated.' }
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
   params.require(:admission).permit(:admission_no,:branch,:surname,:second_lang,:board,:grade,:medium,:year,:written,:spoken,:reading,:blood_group,:allergy,:doctor_name,:doctor_mobile,:guardian_name,:guardian_mobile,:guardian_relationship,:from,:to,:avatar,:father_office_address,:mother_office_address,:father_office_telephone,:mother_office_telephone,:father_mobile,:mother_mobile,:father_religion,:mother_religion,:father_employer,:mother_employer,:father_email,:mother_email,:sib_name1,:sib_age1,:sib_sex1,:sib_grade1,:sib_school1,:sib_name2,:sib_age2,:sib_sex2,:sib_grade2,:sib_school2,:bus,:form_no, :middle_name,:name,:klass, :dob,:gender,:nationality,:language,:father_name,:mother_name,:father_occupation,:mother_occupation,:father_company,:mother_company,:father_education, :mother_education,:income,:address_line1, :address_line2, :previous_city, :pin, :landline,:mobile,:email,:transport, :busstop,:last_school, :city, :changing_reason, :know_school,:person, :pp,:status,:closestatus,:title, :description, :staff, :grade, :start_time, :end_time, :grade_master_id,:teacher_leader_id,:faculty,:comment, :result,:teachercomment,:finalresult, :father_nationality, :mother_nationality,:section_master_id, :school_house)
 end
 def get_student_master(student_obj)
     StudentMaster.new do |sm|
     sm.admission_no = student_obj.admission_no
     sm.name = student_obj.name
     sm.branch = student_obj.branch
     sm.surname = student_obj.surname
     sm.second_lang = student_obj.second_lang
     sm.blood_group = student_obj.blood_group
     sm.guardian_relationship = student_obj.guardian_relationship
     sm.guardian_name = student_obj.guardian_name
     sm.dob = student_obj.dob
     sm.gender = student_obj.gender
     sm.nationality = student_obj.nationality
     sm.language = student_obj.language
     sm.allergy = student_obj.allergy
     sm.doctor_name = student_obj.doctor_name
     sm.doctor_mobile = student_obj.doctor_mobile
     sm.bus_facility = student_obj.bus
     sm.grade_master_id = student_obj.grade_master_id
     sm.section_master_id = student_obj.section_master_id
     sm.school_house = student_obj.school_house
   end 
 end

 def get_parent_master(student_obj)
   ParentMaster.new do |sm|
     sm.address_line1 = student_obj.address_line1
     sm.address_line2 = student_obj.address_line2
     sm.city = student_obj.city
     sm.pin = student_obj.pin
     sm.father_name = student_obj.father_name
     sm.mother_name = student_obj.mother_name
     sm.father_mobile = student_obj.father_mobile
     sm.mother_mobile = student_obj.mother_mobile
     sm.father_email = student_obj.father_email
     sm.mother_email = student_obj.mother_email
     sm.father_office_address = student_obj.father_office_address
     sm.mother_office_address = student_obj.mother_office_address
     sm.father_occupation = student_obj.father_occupation
     sm.mother_occupation = student_obj.mother_occupation
     sm.father_religion = student_obj.father_religion
     sm.mother_religion = student_obj.mother_religion
     sm.father_nationality = student_obj.father_nationality
     sm.mother_nationality = student_obj.mother_nationality
     sm.father_company = student_obj.father_company
     sm.mother_company = student_obj.mother_company
     sm.father_education = student_obj.father_education
     sm.mother_education = student_obj.mother_education
     sm.father_office_telephone = student_obj.father_office_telephone
     sm.mother_office_telephone = student_obj.mother_office_telephone
     sm.father_employer = student_obj.father_employer
     sm.mother_employer = student_obj.mother_employer
     sm.student_master_id = student_obj.id
   end
 end
end
