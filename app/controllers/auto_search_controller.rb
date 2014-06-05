class AutoSearchController < ApplicationController
  def autocomplete_student_by_name
    term = params[:term]
    students = Student.where("lower(form_no) ILIKE '%#{term}%' OR lower(name) ILIKE '%#{term}%'").order(:name)
    render :json => students.map { |student| {:id => student.id, :label => student.name, :value => student.name} }
  end

  def student_name_by_grade_and_section
    term = params[:term]
    query = "lower(name) ILIKE '%#{term}%' "

    if params[:grade].present?
      query = query + " and grade = #{params[:grade]}"
    end
    
    if params[:section].present?
      query = query + " and section = #{params[:section]}"
    end
    students = StudentHr.where(query).order(:name)
    render :json => students.map { |student| {:id => student.id, :label => student.name, :value => student.name} }
  end
end


