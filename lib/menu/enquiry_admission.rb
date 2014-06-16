class EnquiryAdmission
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << new_enquiry_admissions
    sub_menu << show_enquiry_admissions
    sub_menu << show_application_admissions    
    sub_menu
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

  def new_enquiry_admissions
    MenuItem.new(:label => "New Enquiry", :klass => "", :icon => "bell", :href => "/admissions/enquiry_new" )
  end
  def show_enquiry_admissions
    MenuItem.new(:label => "Enquiry Forms", :klass => "", :icon => "file", :href => "/admissions/enquiry_index" )
  end
  def show_application_admissions
    MenuItem.new(:label => "Application Forms", :klass => "", :icon => "file-text", :href => "/admissions/admission_index" )
  end
end
