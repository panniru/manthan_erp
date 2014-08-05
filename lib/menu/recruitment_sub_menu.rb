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
  
  end
  
  def transport_head_sub_menu
    sub_menu = []
    sub_menu << transport_assessment
    sub_menu << show_closed_forms
  end
  
  def principal_sub_menu
    sub_menu = []
    sub_menu << senior_management_review
    sub_menu << assessment_completed
    sub_menu << assessment_planned
    sub_menu << documentation_verification
    sub_menu << enquiry_form
    sub_menu << show_closed_forms
  end

  private 
  def home
    MenuItem.new(:label => "Home", :klass => "", :icon => "home ", :href => "/staff_admissions")
  end
  def  guidelines
    MenuItem.new(:label => "Guidelines", :klass => "", :icon => "pencil-square-o ", :href => "/recruitments")
  end
  def  advertisements
    MenuItem.new(:label => "Advertisements", :klass => "", :icon => "puzzle-piece ", :href => "/adds")
  end
  def  enquiry_form
    MenuItem.new(:label => "Enquiry Forms", :klass => "", :icon => "file-text-o", :href => "/staff_admissions/enquiry_index")
  end
  def  documentation_verification
    MenuItem.new(:label => "Documentation verification", :klass => "", :icon => "folder-open", :href => "/recruitments/document_index")
  end
  def assessment_planned
    MenuItem.new(:label => "Assessment Planned", :klass => "", :icon => "calendar ", :href => "/recruitments/assessment_index")
  end
  def assessment_completed
    MenuItem.new(:label => "Assessment Completed", :klass => "", :icon => "file-archive-o ", :href => "/recruitments/assessment_completed_index")
  end
  def senior_management_review
    MenuItem.new(:label => "Sr Management Review", :klass => "", :icon => "group ", :href => "/recruitments/management_index")
  end
  def appointed
    MenuItem.new(:label => "Appointed", :klass => "", :icon => "user ", :href => "/recruitments/selected_staffs")
  end
  def transport_assessment
    MenuItem.new(:label => "Assessment", :klass => "", :icon => "group", :href => "/recruitments/sports_index")
  end
  def show_closed_forms
    MenuItem.new(:label => "Closed Forms", :klass => "", :icon => "ban", :href => "/recruitments/closed_forms" )
  end
end

