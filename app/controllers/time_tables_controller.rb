class TimeTablesController < ApplicationController
  def index
  end

  def gradeserviceview
    respond_to do |format|
      format.json do
        grades = GradeMaster.all.map do |grade|
          {grade: grade.grade, id: grade.id}
        end
        render :json => grades
      end
    end  
  end

  def sectionserviceview
    respond_to do |format|
      format.json do
        sections = SectionMaster.all.map do |section|
          {section: section.section, id: section.id}
        end
        render :json => sections
      end
    end  
  end
  
  def subjectserviceview
    respond_to do |format|
      format.json do
        sections = SubjectMaster.all.map do |subject|
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
    #puts(params)
    #p "================"
    #p params[:time_periods]   
    #p "+++++++++++++++++++++"         
    params[:time_periods].each do |t|
      @timetable=TimeTable.new(t)
      if @timetable.save
        redirect_to time_tables_path
      else
        render "index"  
      end
    end
  end

  def timetableserviceview
    respond_to do |format|
      format.json do
        sections = TimeTable.all
        render :json => sections
      end
    end  
  end
end
