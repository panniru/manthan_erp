class ResultsController < ApplicationController


  def get_all_results
    result = Result.all.where(:grade_master_id => params[:klass]).map do |x|
      {student_name: x.student_master.name, grade: x.grade_master.grade_name,grading: x.grading_master.grading_name, result: x.grading_master.grading_desc }
    end
    respond_to do |format|
      format.json do
        render :json => result
      end
      format.html do
      end
    end
  end

  def get_klasses
    result = GradeMaster.all
    respond_to do |format|
      format.json do
        render :json => result
      end
      format.html do
      end
    end
  end




  







end
