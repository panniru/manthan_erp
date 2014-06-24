class RecruitmentSubMenu


  def admin_sub_menu
    sub_menu = []
    sub_menu << guidelines
    sub_menu << advertisements
    sub_menu << enquiry_form
    sub_menu << documentation_verification
    sub_menu << interview_scheduler
    
  end

  private 
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
    MenuItem.new(:label => "Interview Scheduler", :klass => "", :icon => "calendar ", :href => "/interviewschedulers")
  end
end

