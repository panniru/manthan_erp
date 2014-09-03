class Canteen
  
 def initialize(args)
   @controller = args[:controller]
  end
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << home
    sub_menu << holiday_calendar
    sub_menu << meal_types
    sub_menu << daily_meals    
  end
  def canteenmanager_sub_menu    
    sub_menu = []
    sub_menu << home       
    sub_menu << daily_meals
    sub_menu << inventory
  end
  def parent_sub_menu
    sub_menu = []
    sub_menu << daily_meals
  end
  private
  def holiday_calendar
    MenuItem.new(:label => "Holiday Calendar", :klass => "", :icon => "calendar", :href => "/holidaycalendars" )
  end
def meal_types
    MenuItem.new(:label => "Meal Types", :klass => "", :icon => "cutlery", :href => "/mealtypes" )
  end
private 
  def home
    MenuItem.new(:label => "Home", :klass => "", :icon => "home ", :href => "/mealtypes/home_index")
    end
  def daily_meals
    MenuItem.new(:label => "Daily Meals", :klass => "", :icon => "cutlery", :href => "/mealnames" )
end
  def inventory
    MenuItem.new(:label => "Inventories", :klass => "", :icon => "cutlery", :href => "/inventories" )
   
  end
 
end
