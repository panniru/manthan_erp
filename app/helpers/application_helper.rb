module ApplicationHelper
  def flash_alert_class(key)
    key = 'danger' if key == :error or key == :alert
    alert_class = ["alert"]
    alert_class << "alert-dismissable"
    if key.to_s == "fail"
      alert_class << "alert-danger "
    elsif key == :notice
      alert_class << "alert-info "
    else
      alert_class << "alert-#{key}"
    end
    alert_class.join(" ")
  end
  
  def main_menu_list
    main_menu = []
    main_menu << MenuItem.new(:label => "Fee Management", :klass => "", :icon => "bank 2x", :href => root_path, :is_active => controller.controller_name == "home")
    main_menu << MenuItem.new(:label => "Admissions", :klass => "", :icon => "book 2x", :href => "/admissions", :is_active => controller.controller_name == "admissions")
    main_menu << MenuItem.new(:label => "Academics", :klass => "", :icon => "graduation-cap 2x", :href => "/time_tables", :is_active => controller.controller_name == "time_tables")
    main_menu << MenuItem.new(:label => "Results", :klass => "", :icon => "bullhorn 2x", :href => "#", :is_active => false)
    main_menu << MenuItem.new(:label => "HRM", :klass => " ", :icon => "group 2x", :href => "#", :is_active => false)
    main_menu << MenuItem.new(:label => "Recruitment", :klass => " ", :icon => " database  2x", :href => "/recruitments")
  end

  def sub_menu
    user_menu = UserMenu.new(current_user, ContextDetector.get_context(controller.controller_name))
    user_menu.sub_menu
  end
  def admission_sub_menu
    context = "enquiry_admission".classify.constantize.new
    user_menu = UserMenu.new(current_user, context)
    user_menu.admission_sub_menu
  end

  def recruitment_sub_menu
    context = "recruitment".classify.constantize.new
    user_menu = UserMenu.new(current_user,context)
    user_menu.recruitment_sub_menu
  end
 
end
