class Canteen
  
 def initialize(args)
   @controller = args[:controller]
  end
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << home
    sub_menu << holiday_calendar
    sub_menu << meal_types    
  end
  def canteenmanager_sub_menu    
    sub_menu = []
    sub_menu << home
    sub_menu << holiday_calendar   
    sub_menu << canteen_manager
  end

  private
  def holiday_calendar
    MenuItem.new(:label => "Holiday Calendar", :klass => "", :icon => "calendar", :href => "/holidaycalendars" )
  end
def meal_types
    MenuItem.new(:label => "Meal Types", :klass => "", :icon => "cutlery", :href => "/canteen_managements" )
  end
private 
  def home
    MenuItem.new(:label => "Home", :klass => "", :icon => "home ", :href => "/canteen_managements/home_index")
    end
  def canteen_manager
    MenuItem.new(:label => "CanteenManager", :klass => "", :icon => "cutlery", :href => "/canteenmanagers" )
end
 
end
