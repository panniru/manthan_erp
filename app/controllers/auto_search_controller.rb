class AutoSearchController < ApplicationController

  autocomplete :book, :isbn, :full => true, :extra_data => [:name]
  
  autocomplete :faculty_master, :faculty_name, :full => true 

  autocomplete :location_master, :location_name, :full => true 
  
  autocomplete :student_master, :name, :full => true 
  #autocomplete :user, :email, :full => true , :extra_data => [:user_id], :display_value => :auto_complete_user_mail_display
  
 
  def autocomplete_user_email
    term = params[:term]
    users = User.where(:role_id => current_user.can_mail_to).where("lower(email) ILIKE '%#{term}%' OR lower(user_id) ILIKE '%#{term}%'").order(:email)
    render :json => users.map { |user| {:id => user.id, :label => "#{user.name} - #{user.email}", :value => user.name} }
  end

  def autocomplete_student_by_name
    term = params[:term]
    students = Student.where("lower(form_no) ILIKE '%#{term}%' OR lower(name) ILIKE '%#{term}%'").order(:name)
    render :json => students.map { |student| {:id => student.id, :label => student.name, :value => student.name} }
  end

  def student_name_by_grade_and_section
    term = params[:term]
    query = "lower(name) ILIKE '%#{term}%' "

    if params[:grade].present?
      query = query + " and grade_master_id = #{params[:grade]}"
    end
    
    if params[:section].present?
      query = query + " and section_master_id = #{params[:section]}"
    end
    students = StudentMaster.where(query).order(:name)
    render :json => students.map { |student| {:id => student.id, :label => student.name, :value => student.name} }
  end
end


