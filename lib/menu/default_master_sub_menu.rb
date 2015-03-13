class DefaultMasterSubMenu < Struct.new(:controller)
    def admin_sub_menu
      sub_menu = []
      sub_menu << parents
      sub_menu << students
      sub_menu << vendors
      sub_menu << calendar
      sub_menu << time_tables
      sub_menu << designations
      sub_menu << day_ends
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
    def time_tables
    MenuItem.new(:label => "Academic Time Table", :klass => "", :icon => "tasks", :href => "/time_tables" )
    end
    def designations
      MenuItem.new(:label => "Designation", :klass => "", :icon => "tasks", :href => "/designations" )
    end
    def day_ends
      MenuItem.new(:label => "Day Ends", :klass => "", :icon => "calendar-o", :href => "/default_masters/day_ends")
    end
end
