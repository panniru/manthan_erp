class RecruitmentSubMenu < Struct.new(:controller)


  def admin_sub_menu
    sub_menu = []
    sub_menu << home
    sub_menu << enquiry_form
    sub_menu << documentation_verification
    sub_menu << assessment_planned
    sub_menu << assessment_completed
    sub_menu << senior_management_review
    sub_menu << appointed
    sub_menu << advertisements
    sub_menu << show_closed_forms
    sub_menu << admin_settings
    sub_menu << reports
  end
  
  def teacher_sub_menu
    sub_menu = []
    sub_menu << view_schedule
    sub_menu << assessment_completed
  end
  
  def principal_sub_menu
    sub_menu = []
    sub_menu << senior_management_review
    sub_menu << assessment_completed
    sub_menu << assessment_planned
    sub_menu << documentation_verification
    sub_menu << enquiry_form
    
  end

  private 
  def home
    MenuItem.new(:label => "Home", :klass => "", :icon => "home ", :href => "/staffrecruits")
  end
  def  guidelines
    MenuItem.new(:label => "Guidelines", :klass => "", :icon => "pencil-square-o ", :href => "/staffrecruits")
  end
  def  advertisements
    MenuItem.new(:label => "Advertisements", :klass => "", :icon => "puzzle-piece ", :href => "/adds")
  end
  def  enquiry_form
    MenuItem.new(:label => "Enquiry Forms", :klass => "", :icon => "file-text-o", :href => "/staffrecruits/enquiry_index")
  end
  def  documentation_verification
    MenuItem.new(:label => "Documentation verification", :klass => "", :icon => "folder-open", :href => "/staffrecruits/document_index")
  end
  def assessment_planned
    MenuItem.new(:label => "Assessment Planned", :klass => "", :icon => "calendar ", :href => "/staffrecruits/assessment_index")
  end
  def view_schedule
    MenuItem.new(:label => "View Schedule", :klass => "", :icon => "calendar ", :href => "/staffrecruits/assessment_index")
  end
  def assessment_completed
    MenuItem.new(:label => "Assessment Completed", :klass => "", :icon => "file-archive-o ", :href => "/staffrecruits/assessment_completed_index")
  end
  def senior_management_review
    MenuItem.new(:label => "Sr Management Review", :klass => "", :icon => "group ", :href => "/staffrecruits/management_index")
  end
  def appointed
    MenuItem.new(:label => "Appointed", :klass => "", :icon => "user ", :href => "/staffrecruits/selected_staffs")
  end
  def transport_assessment
    MenuItem.new(:label => "Assessment", :klass => "", :icon => "group", :href => "/staffrecruits/sports_index")
  end
  def show_closed_forms
    MenuItem.new(:label => "Closed Forms", :klass => "", :icon => "ban", :href => "/staffrecruits/closed_forms" )
  end
  def admin_settings
    MenuItem.new(:label => "Admin Settings", :klass => "", :icon => "wrench", :href => "/staffadmins" )
  end
  def reports
    MenuItem.new(:label => "Reports", :klass => "", :icon => "print", :href => "/staff_reports" )
  end

end

