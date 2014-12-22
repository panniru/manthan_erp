class AttendanceCtrl

  def initialize(args)
    @controller = args[:controller]
  end
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << daily_faculty
    sub_menu << setup_master
    sub_menu << leave_approval
    
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
    sub_menu << leave_permission
    sub_menu << leave_approval_status
    
  end

  private
  def daily
    MenuItem.new(:label => "Daily Attendance", :klass => "", :icon => "building", :href => "/attendances" )
  end

  def daily_faculty
    MenuItem.new(:label => "Daily Attendance", :klass => "", :icon => "building", :href => "/faculty_attendances" )
  end

  def setup_master
    MenuItem.new(:label => "Master Setup", :klass => "", :icon => "building", :href => "/setup_masters" )
  end

  def leave_permission
    MenuItem.new(:label => "Leave Permission", :klass => "", :icon => "building", :href => "/leave_permissions" )
  end

  def leave_approval_status
    MenuItem.new(:label => "Approval Status", :klass => "", :icon => "building", :href => "/leave_permissions/approval_status" )
  end

  def leave_approval
    MenuItem.new(:label => "Leave Approval", :klass => "", :icon => "building", :href => "/leave_permissions/approval" )
  end


  def week
    MenuItem.new(:label => "Weekly Attendance", :klass => "", :icon => "building", :href => "/attendances/show_week" )
  end

  def month
    MenuItem.new(:label => "Monthly Attendance", :klass => "", :icon => "building", :href => "/attendances/week" )
  end
  


  def holiday_calendar
    MenuItem.new(:label => "Holiday Calendar", :klass => "", :icon => "calendar", :href => "/holidaycalendars" )
  end
end
