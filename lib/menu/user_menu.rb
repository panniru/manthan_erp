class UserMenu
  
  def initialize(user, context = nil, controller_name = nil)
    @user = user
    @context = context
    @controller_name = controller_name
  end

  def main_menu
    if @user.admin? or @user.accountant?
      return admin_main_menu
    elsif @user.parent?
      return parent_main_menu
    else
      return admin_main_menu
    end
  end
  
  def sub_menu
    if @context.present?
      if @user.admin?
        return @context.admin_sub_menu
      elsif @user.parent?
        return @context.parent_sub_menu
      elsif @user.accountant?
        return @context.accountant_sub_menu
      elsif @user.teacher?
        return @context.teacher_sub_menu 
      elsif @user.librarian?
        return @context.librarian_sub_menu      
      elsif @user.principal?
        return @context.principal_sub_menu 
      elsif @user.transport_head?
      return @context.transport_head_sub_menu
      elsif @user.canteenmanager?
        return @context.canteenmanager_sub_menu
      end
    end
    []
  end
  
  private
  
  def admin_main_menu
    main_menu = []
    main_menu << MenuItem.new(:label => "Fee Management", :klass => ContextDetector.mapped_module_name(@controller_name) == "fee_management"? "active" :"", :icon => "bank", :href => "/")
    main_menu << MenuItem.new(:label => "Attendance", :klass => ContextDetector.mapped_module_name(@controller_name) == "attendance_ctrl"? "active" :"", :icon => "building", :href => "/faculty_attendances")
    main_menu << MenuItem.new(:label => "Admissions", :klass => ContextDetector.mapped_module_name(@controller_name) == "enquiry_admission"? "active" :"", :icon => "book", :href => "/admissions/admission_home")
    main_menu << MenuItem.new(:label => "Academics", :klass => ContextDetector.mapped_module_name(@controller_name) == "academic"? "active" :"", :icon => "graduation-cap", :href => "/academics")
    main_menu << MenuItem.new(:label => "Results", :klass => ContextDetector.mapped_module_name(@controller_name) == "result"? "active" :"", :icon => "bullhorn", :href => "#")
    main_menu << MenuItem.new(:label => "HRM", :klass => ContextDetector.mapped_module_name(@controller_name) == "hrm"? "active" :"", :icon => "group", :href => "/?context=HRM")
    main_menu << MenuItem.new(:label => "Recruitment", :klass => ContextDetector.mapped_module_name(@controller_name) == "recruitment_sub_menu"? "active" :"", :icon => "user", :href => "/staffrecruits/recruitment_home")
    main_menu << MenuItem.new(:label => "Defaults", :klass => ContextDetector.mapped_module_name(@controller_name) == "default_master_sub_menu"? "active" :"", :icon => " edit", :href => "/default_masters")
    main_menu << MenuItem.new(:label => "Transport", :klass => ContextDetector.mapped_module_name(@controller_name) == "transport_sub_menu"? "active" :"", :icon => " truck", :href => "/new_vehicles")
    main_menu << MenuItem.new(:label => "Library", :klass => ContextDetector.mapped_module_name(@controller_name) == "library"? "active" :"", :icon => " book", :href => "/libraries")
    main_menu << MenuItem.new(:label => "Canteen Facility", :klass => ContextDetector.mapped_module_name(@controller_name) == "canteen"? "active" :"", :icon => "cutlery", :href => "/mealtypes/home_index")
    main_menu << MenuItem.new(:label => "Non Academics", :klass => ContextDetector.mapped_module_name(@controller_name) == "non_academic"? "active" :"", :icon => "graduation-cap", :href => "/non_academics")
    main_menu << MenuItem.new(:label => "Lab", :klass => ContextDetector.mapped_module_name(@controller_name) == "lab"? "active" :"", :icon => "laptop", :href => "lab_masters")
    main_menu << MenuItem.new(:label => "Payroll", :klass => ContextDetector.mapped_module_name(@controller_name) == "payroll"? "active" :"", :icon => "dollar", :href => "payslips#index")
    main_menu
  end
  
  def parent_main_menu
    main_menu = []
    main_menu << MenuItem.new(:label => "Fee Management", :klass => ContextDetector.mapped_module_name(@controller_name) == "fee_management"? "active" :"", :icon => "bank", :href => "/")
    main_menu << MenuItem.new(:label => "Academics", :klass => ContextDetector.mapped_module_name(@controller_name) == "academic"? "active" :"", :icon => "graduation-cap", :href => "/academics")
    main_menu << MenuItem.new(:label => "Results", :klass => ContextDetector.mapped_module_name(@controller_name) == "result"? "active" :"", :icon => "bullhorn", :href => "#")
    main_menu << MenuItem.new(:label => "HRM", :klass => ContextDetector.mapped_module_name(@controller_name) == "hrm"? "active" :"", :icon => "group", :href => "#")
    main_menu << MenuItem.new(:label => "Recruitment", :klass => ContextDetector.mapped_module_name(@controller_name) == "recruitment_sub_menu"? "active" :"", :icon => "user", :href => "/forms")
    main_menu << MenuItem.new(:label => "Defaults", :klass => ContextDetector.mapped_module_name(@controller_name) == "default_master_sub_menu"? "active" :"", :icon => " edit", :href => "/default_masters")
    main_menu << MenuItem.new(:label => "Transport", :klass => ContextDetector.mapped_module_name(@controller_name) == "transport_sub_menu"? "active" :"", :icon => " truck", :href => "/routes")
    main_menu
    main_menu << MenuItem.new(:label => "Library", :klass => ContextDetector.mapped_module_name(@controller_name) == "library"? "active" :"", :icon => " book", :href => "/libraries")
    main_menu << MenuItem.new(:label => "Attendance", :klass => ContextDetector.mapped_module_name(@controller_name) == "attendance"? "active" :"", :icon => "building", :href => "/attendances")
    main_menu << MenuItem.new(:label => "Canteen Facility", :klass => ContextDetector.mapped_module_name(@controller_name) == "canteen"? "active" :"", :icon => "cutlery", :href => "/mealtypes/home_index")
    main_menu
  end
  
end
  
  
