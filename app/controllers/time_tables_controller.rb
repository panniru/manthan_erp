class TimeTablesController < ApplicationController
  def index
  end

  def gradeserviceview
    respond_to do |format|
      format.json do
        grades = Grade.all.map do |grade|
          {grade: grade.grade, id: grade.id}
        end
        render :json => grades
      end
    end  
  end

  def sectionserviceview
    respond_to do |format|
      format.json do
        sections = Section.all.map do |section|
          {section: section.section, id: section.id}
        end
        render :json => sections
      end
    end  
  end
  
  def subjectserviceview
    respond_to do |format|
      format.json do
        sections = Subject.all.map do |subject|
          {subject: subject.subject, id: subject.id}
        end
        render :json => sections
      end
    end  
  end

  def subjectserviceview
    respond_to do |format|
      format.json do
        sections = Subject.all.map do |subject|
          {subject: subject.subject, id: subject.id}
        end
        render :json => sections
      end
    end  
  end

  def saveperiods
    puts(params)
    timeperiods=params
    p "================"
    p params[:time_periods].first

    respond_to do |format|
      format.json do
      
        render :json => grades
      end
    end  
  end
end
