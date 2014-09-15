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
    sub_menu << holiday_calendar
  end

  private
  def daily
    MenuItem.new(:label => "Daily Attendance", :klass => "", :icon => "building", :href => "/attendances" )
  end
  def holiday_calendar
    MenuItem.new(:label => "Holiday Calendar", :klass => "", :icon => "calendar", :href => "/holidaycalendars" )
  end
end
