class Academic

  def initialize(args)
    @controller = args[:controller]
  end
  
  def admin_sub_menu
    sub_menu = []  
    sub_menu << section_masters  
    sub_menu << grades_sections_mappings
    sub_menu << subject_masters
    sub_menu << grades_subjects_mappings
    sub_menu << teacher_grade_mappings
    sub_menu << teacher_timetables
    sub_menu << class_teacher_mappings
    sub_menu << teaching_plans
    sub_menu << assessment_types
    sub_menu << assessments
    #sub_menu << assessment_criteria
    sub_menu << grading
    #sub_menu << assessment_results
    sub_menu << academic_terms
    sub_menu << term_results
    sub_menu << final_results
    sub_menu
  end
  def teacher_sub_menu
    sub_menu = []
    #sub_menu << time_tables
    sub_menu << teacher_timetables 
    sub_menu << teaching_plans
    #sub_menu << assessment_criteria
    sub_menu << assessments
    sub_menu << assessment_results
    #sub_menu << term_results
    sub_menu
  end
  def parent_sub_menu
    sub_menu = [] 
    #sub_menu << time_tables
    sub_menu << teaching_plans
    sub_menu
  end
  def principal_sub_menu
    sub_menu = [] 
    sub_menu << term_results    
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

   def assessments
    MenuItem.new(:label => "Assessments", :klass => "", :icon => "list-ol", :href => "/assessments")
  end

  def assessment_results
    MenuItem.new(:label => "Assessments Results", :klass => "", :icon => "list-ol", :href => "/assessment_results")
  end

  def academic_terms
    MenuItem.new(:label => "Academic Terms", :klass => "", :icon => "list-ol", :href => "/academic_terms")
  end

  def term_results
    MenuItem.new(:label => "Term Results", :klass => "", :icon => "thumbs-up", :href => "/term_results")
  end

  def subject_masters
    MenuItem.new(:label => "Subject Masters", :klass => "", :icon => "thumbs-up", :href => "/subject_masters")
  end

  def section_masters
    MenuItem.new(:label => "Section Masters", :klass => "", :icon => "thumbs-up", :href => "/section_masters")
  end

  def assessment_types
    MenuItem.new(:label => "Assessments Types", :klass => "", :icon => "list-ol", :href => "/assessment_types")
  end

  def final_results
    MenuItem.new(:label => "Final Grading", :klass => "", :icon => "list-ol", :href => "/final_results")
  end

end
