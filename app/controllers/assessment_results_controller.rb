class AssessmentResultsController < ApplicationController
  def index
    if current_user.admin?
      render "index"     
    elsif  current_user.teacher?
      render "teacher_index"
    end
  end
end
