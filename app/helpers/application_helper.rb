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
    main_menu << MenuItem.new(:label => "Fee Management", :klass => ContextDetector.mapped_module_name(controller.controller_name) == "fee_management"? "active" :"", :icon => "bank", :href => root_path)
    main_menu << MenuItem.new(:label => "Admissions", :klass => ContextDetector.mapped_module_name(controller.controller_name) == "enquiry_admission"? "active" :"", :icon => "book", :href => "/admissions")
    main_menu << MenuItem.new(:label => "Academics", :klass => ContextDetector.mapped_module_name(controller.controller_name) == "academic"? "active" :"", :icon => "graduation-cap", :href => "/academics")
    main_menu << MenuItem.new(:label => "Results", :klass => ContextDetector.mapped_module_name(controller.controller_name) == "result"? "active" :"", :icon => "bullhorn", :href => "#")
    main_menu << MenuItem.new(:label => "HRM", :klass => ContextDetector.mapped_module_name(controller.controller_name) == "hrm"? "active" :"", :icon => "group", :href => "#", :is_active => false)
    main_menu << MenuItem.new(:label => "Recruitment", :klass => ContextDetector.mapped_module_name(controller.controller_name) == "recruitment_sub_menu"? "active" :"", :icon => " database", :href => "/recruitments")
    main_menu << MenuItem.new(:label => "Defaults", :klass => ContextDetector.mapped_module_name(controller.controller_name) == "default_master_sub_menu"? "active" :"", :icon => " edit", :href => "/default_masters")
  end

  def sub_menu
    user_menu = UserMenu.new(current_user, ContextDetector.get_context(controller.controller_name))
    user_menu.sub_menu
  end

end

