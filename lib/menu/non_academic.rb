class NonAcademic
  def initialize(args)
    @controller = args[:controller]
  end

  def admin_sub_menu
    sub_menu = []  
    sub_menu << activity_masters 
    sub_menu
  end

  private

  def activity_masters
    MenuItem.new(:label => "Activity Masters", :klass => "", :icon => "tasks", :href => "/activity_masters" )
  end

end
