class EnquiryAdmission
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << home
    sub_menu << show_enquiry_admissions
    sub_menu << show_application_admissions    
    sub_menu << show_staff_admissions
    sub_menu << show_event_admissions
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
    MenuItem.new(:label => "Home", :klass => "", :icon => "bell", :href => "/admissions/admission_home" )
  end
 
  def show_enquiry_admissions
    MenuItem.new(:label => "Enquiry Forms", :klass => "", :icon => "file", :href => "/admissions/enquiry_index" )
  end
  def show_application_admissions
    MenuItem.new(:label => "Application Forms", :klass => "", :icon => "file-text", :href => "/admissions/admission_index" )
  end
  def show_staff_admissions
    MenuItem.new(:label => "Assessment list", :klass => "", :icon => "book", :href => "/staffs" )
  end
  def show_event_admissions
    MenuItem.new(:label => "Events list", :klass => "", :icon => "calendar", :href => "/events" )
  end
end
