class Academic < Struct.new(:controller)
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << time_tables
    sub_menu << teacher_timetables
    sub_menu << teaching_plans
    sub_menu << teacher_grade_mappings
    sub_menu
  end

  
  private

  def time_tables
    MenuItem.new(:label => "Academic Time Table", :klass => "", :icon => "tasks", :href => "/time_tables" )
  end

  def teacher_timetables
    MenuItem.new(:label => "Teachers Timetable", :klass => "archive", :icon => "codepen", :href => "/teachers_time_tables")
  end

  def teaching_plans
    MenuItem.new(:label => "Teaching Plan", :klass => "", :icon => "cubes", :href => "/teaching_plans")
  end
  
  def teacher_grade_mappings
    MenuItem.new(:label => "Teacher Grade Mapping", :klass => "", :icon => "arrows-h", :href => "/teacher_grade_mappings")
  end

end
