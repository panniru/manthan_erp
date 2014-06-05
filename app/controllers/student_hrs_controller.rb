class StudentHrsController < ApplicationController
  load_resource :only => [:show]
  def index
    if current_user.admin?
      @student_hrs = Student.all
    elsif current_user.parent?
      @student_hrs = current_user.parent.students
    end
  end

  def show
    respond_to do |format|
      format.json do
        render :json => @student_hr
      end
      format.html do
        render "show"
      end
    end
  end
  
end
