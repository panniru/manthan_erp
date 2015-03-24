class Lab

  def initialize(args)
    @controller = args[:controller]
  end
  

  def admin_sub_menu
    sub_menu = []
    sub_menu << lab_masters
    sub_menu << lab_criterias
    sub_menu << grade_lab_mappings
    sub_menu << lab_teacher_mappings
    sub_menu << lab_assessments
  end


 
  private
 
  def lab_masters
    MenuItem.new(:label => "Lab Masters", :klass => "", :icon => "codepen", :href => "/lab_masters")
  end

  def lab_criterias
    MenuItem.new(:label => "Lab Criteria", :klass => "", :icon => "list-ol ", :href => "/lab_criterias")
  end
  
  def grade_lab_mappings
    MenuItem.new(:label => "Grade Lab Mapping", :klass => "", :icon => "arrows-h", :href => "/grade_lab_mappings")
  end

  def lab_teacher_mappings
    MenuItem.new(:label => "Lab Teacher Mapping", :klass => "", :icon => "arrows-h", :href => "/lab_teacher_mappings")
  end

  def lab_assessments
    MenuItem.new(:label => "Lab Assessments", :klass => "", :icon => "list-ol", :href => "/lab_assessments")
  end
  
end

