class RecruitmentSubMenu


  def admin_sub_menu
    sub_menu = []
    sub_menu << guidelines
    sub_menu << advertisements
    sub_menu << enquiry_form
    sub_menu << documentation_verification
    sub_menu
  end

  private 
  def  guidelines
    MenuItem.new(:label => "Guidelines", :klass => "", :icon => "openid", :href => "/recruitments")
    end
  def  advertisements
    MenuItem.new(:label => "Advertisements", :klass => "", :icon => "loptop", :href => "/adds")
    end
  def  enquiry_form
    MenuItem.new(:label => "Enquiry_from", :klass => "", :icon => "file-word-o", :href => "/forms")
    end
  def  documentation_verification
    MenuItem.new(:label => "Documentation_verification", :klass => "", :icon => "folder-open-o", :href => "/documentuploaders")
  end
end


