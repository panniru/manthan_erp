module StudentReport
  
  class Attendence
    def initialize(std)
      @student = std
    end
    
    def month_report(month)
      date = month
      fetch_month_data do |day|
        {date: day.attendance_date, status: day.attendace}
      end
    end
  
    def month_report_for_full_calendar(month)
      fetch_month_data(month) do |day|
        {:title => day.attendance, start: day.attendance_date, :color => attendance_based_color(day.attendance)}
      end
    end
    
    def student_summarized_monthly_report
      Attendance.student_summarized_monthly_report(@student.id)
    end
    
    def self.this_week(date, current_user)
      if(ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.id}").length != 0)
        pa="#{current_user.id}"
        
        show_attendance_date = []

        show_attendance_date  = Attendance.where(:faculty_master_id => pa).this_weekend.group_by(&:student_master_id).each.map do |show_attendance|
          {id: show_attendance.id, attendance: show_attendance.attendance, date: show_attendance.attendance_date, student_name: show_attendance.student_master.name}
          
        end
      end
      show_attendance_date
    end

    def self.students_attendance_on_date(date, faculty)
      attendances = Attendance.on_date(date).taken_by_faculty(faculty.id)
      data = []
      
      if attendances.count > 0
        data = attendances.map do |attendance|
          {date: date, attendance: attendance.attendance, name: attendance.student_master.name, student_id: attendance.student_master.id, faculty_id: faculty.id, id: attendance.id}
        end
      else
        section_master = ClassTeacherMapping.show_all_students(faculty.id).first.try(:grade_master)
        date = Date.today
        if section_master.present?
          data = section_master.students.map do |student|
            {date: date, attendance: "", name: student.name, student_id: student.id, faculty_id: faculty.id}
          end
        end
      end
      data
    end
    
    private
    
    def fetch_month_data(month)
      @student.attendances.belongs_to_month(month).map do |day|
        yield day if block_given?
      end
    end

    def attendance_based_color(attendance)
      case attendance
      when "P"
        "green"
      when "A"
        "red"
      when "L"
        "yellow"
      else
        "red"
      end
    end
  end
end
