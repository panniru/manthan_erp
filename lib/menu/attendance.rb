class Attendance

  def initialize(args)
    @controller = args[:controller]
  end
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << daily
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
  end

  private
  def daily
    MenuItem.new(:label => "Daily Attendance", :klass => "", :icon => "building", :href => "/attendances" )
  end
end
