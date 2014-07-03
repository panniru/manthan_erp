class RecruitmentSubMenu < Struct.new(:controller)


  def admin_sub_menu
    sub_menu = []
    sub_menu << home
    sub_menu << guidelines
    sub_menu << advertisements
    sub_menu << enquiry_form
    sub_menu << documentation_verification
    sub_menu << interview_scheduler
    sub_menu << assessment_completed
    sub_menu << senior_management_review
    sub_menu << appointed
    
  end

  private 
  def home
    MenuItem.new(:label => "Home", :klass => "", :icon => "home ", :href => "/forms")
    end
  def  guidelines
    MenuItem.new(:label => "Guidelines", :klass => "", :icon => "pencil-square-o ", :href => "/recruitments")
    end
  def  advertisements
    MenuItem.new(:label => "Advertisements", :klass => "", :icon => "puzzle-piece ", :href => "/adds")
    end
  def  enquiry_form
    MenuItem.new(:label => "Enquiry", :klass => "", :icon => "file-text-o", :href => "/forms")
    end
  def  documentation_verification
    MenuItem.new(:label => "Documentation verification", :klass => "", :icon => "folder-open", :href => "/documentuploaders")
  end
  def interview_scheduler
    MenuItem.new(:label => "Assessment Scheduler", :klass => "", :icon => "calendar ", :href => "/interviewschedulers")
  end
  def assessment_completed
    MenuItem.new(:label => "Assessment Completed", :klass => "", :icon => "file-archive-o ", :href => "#")
    end
  def senior_management_review
    MenuItem.new(:label => "Sr Management Review", :klass => "", :icon => "group ", :href => "#")
    end
  def appointed
    MenuItem.new(:label => "Appointed", :klass => "", :icon => "user ", :href => "#")
    end
end

