class Lab

  def initialize(args)
    @controller = args[:controller]
  end
  

  def admin_sub_menu
    sub_menu = []
    sub_menu << lab_masters
  end


 
  private
 
  def lab_masters
    MenuItem.new(:label => "Lab Masters", :klass => "", :icon => "cog", :href => "/lab_masters")
  end
 
end

