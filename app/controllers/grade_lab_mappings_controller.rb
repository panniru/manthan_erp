class GradeLabMappingsController < ApplicationController
  def index
  end
  
  def all_subjects
    lab_masters = LabMaster.all.map do |lab_master|
      {lab_name: lab_master.lab_name , id: lab_master.id }
    end
    render :json => lab_masters
  end

  def new
  end

  def show
  end

  def edit
  end
end
