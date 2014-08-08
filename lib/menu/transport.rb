class Transport

  def initialize(args)
    @controller = args[:controller]
  end


  def admin_sub_menu
    sub_menu = []
    sub_menu << newbus
    sub_menu << routes
    sub_menu << mappings
      
  end


  def parent_sub_menu
    sub_menu = []
    sub_menu << routes
    sub_menu
  end

  private 
  def newbus
    MenuItem.new(:label => "Buses", :klass => "", :icon => "tachometer ", :href => "/new_vehicles")
  end
  def routes
    MenuItem.new(:label => "Routes", :klass => "", :icon => "arrows-alt", :href => "/routes")
  end
  def mappings
    MenuItem.new(:label => "Mapping", :klass => "", :icon => "arrows-h ", :href => "/student_route_mappings")
  end
end

