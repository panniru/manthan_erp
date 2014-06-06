module FeeManagementHelper
  
  def self.sub_menu_list
    sub_menu = []

    sub_menu << MenuItem.new(:label => "Fee Types", :klass => "", :icon => "tasks", :href => "fee_types_path")

    sub_menu << MenuItem.new(:label => "Grade Buckets", :klass => "archive", :icon => "codepen", :href => "fee_grade_buckets_path")

    sub_menu << MenuItem.new(:label => "Terms", :klass => "", :icon => "cubes", :href => "term_definitions_path")

    sub_menu << MenuItem.new(:label => "Monthly PDCs", :klass => "", :icon => "calendar-o", :href => "#")
    
    sub_menu << MenuItem.new(:label => "Fee Structure", :klass => "", :icon => "th", :href => "grade_wise_fees_path")
    
    sub_menu << MenuItem.new(:label => "Approvals", :klass => "", :icon => "square" , :href => "grade_wise_fees_path")

  
  end

end
