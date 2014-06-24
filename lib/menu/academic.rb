class Academic
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << time_tables
    sub_menu << teacher_timetable
    sub_menu << teaching_plan
    sub_menu
  end

  
  private

  def time_tables
    MenuItem.new(:label => "Time Table", :klass => "", :icon => "tasks", :href => "/time_tables" )
  end

  def teacher_timetable
    MenuItem.new(:label => "Teacher Timetable", :klass => "archive", :icon => "codepen", :href => "/time_tables")
  end

  def teaching_plan
    MenuItem.new(:label => "Teaching Plan", :klass => "", :icon => "cubes", :href => "/teaching_plans")
  end

end
