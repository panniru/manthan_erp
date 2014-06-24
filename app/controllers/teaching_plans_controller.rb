class TeachingPlansController < ApplicationController
  def index
    @teaching_plans = TeachingPlan.all
  end
  def new
    @teaching_plan = TeachingPlan.new
  end
  def edit
  end
  def show
  end

  def gradeserviceview
    respond_to do |format|
      format.json do
        grades = TeacherGradeMapping.all.map do |grade|
          {grade: grade.grade_master_id.to_i, id: grade.id }
        end
        render :json => grades
      end
    end  
  end
  def sectionservicview
    respond_to do |format|
      format.json do
        sections = TeacherGrademapping.all.map do |section|
          {section: section.section_master_id, id: section.id }
        end
        render :json => sections
      end
    end  
  end
end
