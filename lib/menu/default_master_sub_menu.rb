class DefaultMasterSubMenu < Struct.new(:controller)
    def admin_sub_menu
      sub_menu = []
      sub_menu << parents
      sub_menu << students
      sub_menu << vendors
      sub_menu << calendar
    end
    
    def parent_sub_menu
      []
    end

    def accountant_sub_menu
      []
    end
    
    private
    def parents
      MenuItem.new(:label => "Parents", :klass => controller == "parents" ? "active" : "", :icon => "user", :href => "/parents")
    end

    def students
      MenuItem.new(:label => "Students", :klass => controller == "student_masters" ? "active" : "", :icon => "user", :href => "/student_masters")
    end
    def vendors
      MenuItem.new(:label => "Vendors", :klass => "", :icon => "vine", :href => "/vendor_categories")
    end
    def calendar
      MenuItem.new(:label => "Holiday Calendar", :klass => "", :icon => "calendar", :href => "/holidaycalendars" )
    end
end
