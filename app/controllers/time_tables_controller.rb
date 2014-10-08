class TimeTablesController < ApplicationController
  def index
    if current_user.admin?
      render "index"      
    elsif  current_user.parent?
      render "parent_index"
    elsif  current_user.teacher?
      render "teacher_index"
    end 
  end

  def gradeserviceview
    respond_to do |format|
      format.json do
        grades = GradeMaster.get_grades_by_role(current_user)
        render :json => grades        
      end
    end  
  end

  def sectionserviceview
    respond_to do |format|
      format.json do
        sections = SectionMaster.get_sections_by_role(current_user)        
        render :json => sections
      end
    end  
  end  
  def subjectserviceview
    respond_to do |format|
      format.json do
        get_subjects = SubjectMaster.all.map do |subject|
          {subject_name: subject.subject_name, subject_master_id: subject.id}
          end
        render :json => get_subjects
      end
    end  
  end   
   
  def saveperiods
    respond_to do |format|
      format.json do
        params[:time_periods].each do |t| 
          if t["id"].present?           
            temp=TimeTable.find(t["id"])        
            temp.mon_sub=t["mon_sub"]
            temp.tue_sub=t["tue_sub"]
            temp.wed_sub=t["wed_sub"]
            temp.thu_sub=t["thu_sub"]
            temp.fri_sub=t["fri_sub"]
            temp.sat_sub=t["sat_sub"]
            temp.sun_sub=t["sun_sub"]
            temp.save
          else
            @timetable=TimeTable.new(add_params(t))            
            @timetable.save
          end
        end
        render :json => true
      end
    end
  end

  def timetableserviceview
    respond_to do |format|
      format.json do
        timetables = TimeTable.all.map do |t|
          {grade:t.grade_master_id,section:t.section_master_id}
        end
        render :json => timetables
      end
    end      
  end
 
  def checktimetable
    respond_to do |format|
      format.json do
        timetables = TimeTable.where('grade_master_id = '+"'#{params[:my_Grade]}'"+" AND "+'section_master_id = '+"'#{params[:my_Section]}'").count 
        render :json => timetables
      end
    end  
  end

  def getperiods
    respond_to do |format|
      format.json do    
        timetables = TimeTable.where('grade_master_id = '+"'#{params[:my_Grade]}'"+" AND "+'section_master_id = '+"'#{params[:my_Section]}'")
        timetables = timetables.map do |timetable|
          {id: timetable.id, grade_master_id: timetable.grade_master_id, section_master_id: timetable.section_master_id, mon_sub: timetable.mon_sub.to_i,tue_sub: timetable.tue_sub.to_i, wed_sub: timetable.wed_sub.to_i, thu_sub: timetable.thu_sub.to_i, fri_sub: timetable.fri_sub.to_i, sat_sub: timetable.sat_sub.to_i, mon_sub_name: SubjectMaster.get_sub_name(timetable.mon_sub.present?,timetable.mon_sub.to_i), tue_sub_name: SubjectMaster.get_sub_name(timetable.tue_sub.present?,timetable.tue_sub.to_i), wed_sub_name: SubjectMaster.get_sub_name(timetable.wed_sub.present?,timetable.wed_sub.to_i), thu_sub_name: SubjectMaster.get_sub_name(timetable.thu_sub.present?,timetable.thu_sub.to_i), fri_sub_name: SubjectMaster.get_sub_name(timetable.fri_sub.present?,timetable.fri_sub.to_i), sat_sub_name: SubjectMaster.get_sub_name(timetable.sat_sub.present?,timetable.sat_sub.to_i)}
        end    
        render :json => timetables
        p timetables
      end
    end
  end

  def defaultperiodsserviceview
    respond_to do |format|
      format.json do    
        defaultperiods = DefaultMaster.all
        defaultperiods = DefaultMaster.where('default_name = '+"'no_of_periods'")
        defaultperiods = defaultperiods[0].default_value
        render :json => defaultperiods
      end
    end
  end

  def get_sections_for_grade    
    grade_sections = GradeSection.where('grade_master_id = '+"'#{params[:my_Grade]}'")
    grade_sections = grade_sections.each.map do |grade_section|
      {id: grade_section.id, grade_master_id: grade_section.grade_master_id, section_master_id: grade_section.section_master_id, section_name: grade_section.section_master.section_name }
    end       
    render  :json => grade_sections
  end

  def get_subjects_for_grade    
    grade_subjects = GradeSubjectMapping.where('grade_master_id = '+"'#{params[:my_Grade]}'")
    grade_subjects = grade_subjects.each.map do |grade_subject|
      {id: grade_subject.id, grade_master_id: grade_subject.grade_master_id, subject_master_id: grade_subject.subject_master_id, subject_name: grade_subject.subject_master.subject_name }
    end       
    render  :json => grade_subjects
  end

  def add_params(params)
    params.permit(:academic_year, :grade_master_id, :section_master_id, :period_id, :mon_sub, :tue_sub, :wed_sub, :thu_sub, :fri_sub, :sat_sub, :sun_sub, :st_time, :end_time)
  end
end
