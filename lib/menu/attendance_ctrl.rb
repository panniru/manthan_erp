class AttendanceCtrl

  def initialize(args)
    @controller = args[:controller]
  end
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << daily
    
  end

  def principal_sub_menu
    sub_menu = []
  end
  
  def parent_sub_menu
    sub_menu = []
    sub_menu << daily
  end
  
  def teacher_sub_menu
    sub_menu = []
    sub_menu << daily
    sub_menu << week
    sub_menu << month
  end

  private
  def daily
    MenuItem.new(:label => "Daily Attendance", :klass => "", :icon => "building", :href => "/attendances" )
  end

  def week
    MenuItem.new(:label => "Weekly Attendance", :klass => "", :icon => "building", :href => "/attendances/show_week" )
  end

  def month
    MenuItem.new(:label => "Monthly Attendance", :klass => "", :icon => "building", :href => "/attendances/monthly_attendance" )
  end
  


  def holiday_calendar
    MenuItem.new(:label => "Holiday Calendar", :klass => "", :icon => "calendar", :href => "/holidaycalendars" )
  end
end
