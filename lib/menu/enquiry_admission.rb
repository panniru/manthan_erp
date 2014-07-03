class EnquiryAdmission < Struct.new(:controller)
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << home
    sub_menu << show_enquiry_admissions
    sub_menu << show_application_admissions    
    sub_menu << show_staff_admissions
    sub_menu << show_event_admissions
    sub_menu << show_closed_forms
  end

  def parent_sub_menu
    sub_menu = []
    sub_menu << fee_structure
    sub_menu
  end
  
  def accountant_sub_menu
    sub_menu = []
    sub_menu << fee_structure
    sub_menu
  end


  private
  def home
    MenuItem.new(:label => "Home", :klass => "", :icon => "home", :href => "/admissions/admission_home" )
  end
 
  def show_enquiry_admissions
    MenuItem.new(:label => "Enquiry Forms ", :klass => "", :icon => "file", :href => "/admissions/enquiry_index" )
  end
  def show_application_admissions
    MenuItem.new(:label => "Application Forms ", :klass => "", :icon => "file-text", :href => "/admissions/admission_index" )
  end
  def show_staff_admissions
    MenuItem.new(:label => "Assessments", :klass => "", :icon => "book", :href => "/staffs" )
  end
  def show_event_admissions
    MenuItem.new(:label => "Scheduled Events", :klass => "", :icon => "calendar", :href => "/events" )
  end
  def show_closed_forms
    MenuItem.new(:label => "Closed Forms", :klass => "", :icon => "ban", :href => "/admissions/closed_forms" )
  end
end
