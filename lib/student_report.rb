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
