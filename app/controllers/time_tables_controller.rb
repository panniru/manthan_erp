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
        #p a        
        #p "===========>"
        #sections = SectionMaster.all.map do |section|
          #{section_master_id: section.id, section_name: section.section_name, grade_master_id: section.grade_master_id }
        #end
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
            @timetable=TimeTable.new(t)            
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
end
