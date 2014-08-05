class Academic

  def initialize(args)
    @controller = args[:controller]
  end
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << grades_sections_mappings
    sub_menu << grades_subjects_mappings
    sub_menu << time_tables
    sub_menu << teacher_grade_mappings
    sub_menu << class_teacher_mappings
    sub_menu << teacher_timetables
    sub_menu << teaching_plans
    sub_menu << assessment_criteria
    sub_menu << grading
    sub_menu
  end
  def teacher_sub_menu
    sub_menu = []
    sub_menu << time_tables
    sub_menu << teacher_timetables 
    sub_menu << teaching_plans
    sub_menu
  end
  def parent_sub_menu
    sub_menu = [] 
    sub_menu << time_tables
    sub_menu << teaching_plans
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

  def class_teacher_mappings
    MenuItem.new(:label => "Class Teacher Mapping", :klass => "", :icon => "arrows-h", :href => "/class_teacher_mappings")
  end

  def grades_sections_mappings
    MenuItem.new(:label => "Grade Sections Mapping", :klass => "", :icon => "arrows-h", :href => "/grades_sections_mappings")
  end

  def grades_subjects_mappings
    MenuItem.new(:label => "Grade Subjects Mapping", :klass => "", :icon => "arrows-h", :href => "/grades_subjects_mappings")
  end

  def assessment_criteria
    MenuItem.new(:label => "Assessment Criteria", :klass => "", :icon => "list-ol", :href => "/assessment_criterias")
  end

  def grading
    MenuItem.new(:label => "Grading", :klass => "", :icon => "list-ol", :href => "/gradings")
  end


end
