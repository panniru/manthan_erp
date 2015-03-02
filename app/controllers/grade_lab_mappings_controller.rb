class GradeLabMappingsController < ApplicationController
  def index
  end
  
  def all_subjects
    subject_masters = SubjectMaster.get_sub_type.map do |subject_master|
      {lab_name: subject_master.subject_name , id: subject_master.id }
    end
    render :json => subject_masters
  end

  def new
  end

  def show
  end

  def edit
  end
end
