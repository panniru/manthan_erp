class AutoSearchController < ApplicationController
  def autocomplete_student_by_name
    term = params[:term]
    students = Student.where("lower(form_no) ILIKE '%#{term}%' OR lower(name) ILIKE '%#{term}%'").order(:name)
    render :json => students.map { |student| {:id => student.id, :label => student.name, :value => student.name} }
  end
end


