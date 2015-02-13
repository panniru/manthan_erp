class NonAcademic
  def initialize(args)
    @controller = args[:controller]
  end

  def admin_sub_menu
    sub_menu = []  
    sub_menu << activity_masters 
    sub_menu << grades_activities_mappings
    sub_menu << activity_teachers_mappings
    sub_menu
  end

  private

  def activity_masters
    MenuItem.new(:label => "Activity Masters", :klass => "", :icon => "tasks", :href => "/activity_masters" )
  end

  def grades_activities_mappings
    MenuItem.new(:label => "Grade Activities", :klass => "", :icon => "tasks", :href => "/grades_activities_mappings" )
  end

  def activity_teachers_mappings
    MenuItem.new(:label => "Activity Teachers", :klass => "", :icon => "tasks", :href => "/activity_teachers_mappings" )
  end

end
