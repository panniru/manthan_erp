module ApplicationHelper
  def flash_alert_class(key)
    key = 'danger' if key == :error or key == :alert
    alert_class = ["alert"]
    if key.to_s == "fail"
      alert_class << "alert-danger"
    elsif key == :notice
      alert_class << "alert-info"
    else
      alert_class << "alert-#{key}"
    end
    alert_class.join(" ")
  end
  
  def main_menu_list
    main_menu = []
    main_menu << MenuItem.new(:label => "Fee Management", :klass => "", :icon => "bank 2x", :href => "#", :is_active => true)
    main_menu << MenuItem.new(:label => "Admissions", :klass => "", :icon => "book 2x", :href => "#", :is_active => false)
    main_menu << MenuItem.new(:label => "Time Tables", :klass => "", :icon => "calendar 2x", :href => "#", :is_active => false)
    main_menu << MenuItem.new(:label => "Results", :klass => "", :icon => "bullhorn 2x", :href => "#", :is_active => false)
    main_menu << MenuItem.new(:label => "HRM", :klass => " ", :icon => "group 2x", :href => "#", :is_active => false)
  end

  def sub_menu
    FeeManagementHelper.sub_menu_list
  end
  
end
