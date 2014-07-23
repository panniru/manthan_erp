class Transport < Struct.new(:controller)


  def admin_sub_menu
    sub_menu = []
    sub_menu << newbus
    sub_menu << routes
      
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
 
end

