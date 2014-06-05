class FeeManagement
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << fee_types
    sub_menu << grade_buckets
    sub_menu << terms
    sub_menu << monthly_pdcs
    sub_menu << fee_structure
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

  def fee_types
    MenuItem.new(:label => "Fee Types", :klass => "", :icon => "tasks", :href => "fee_types_path")
  end

  def grade_buckets
    MenuItem.new(:label => "Grade Buckets", :klass => "archive", :icon => "codepen", :href => "fee_grade_buckets_path")
  end

  def terms
    MenuItem.new(:label => "Terms", :klass => "", :icon => "cubes", :href => "term_definitions_path")
  end

  def monthly_pdcs
    MenuItem.new(:label => "Monthly PDCs", :klass => "", :icon => "calendar-o", :href => "#")
  end

  def fee_structure
    MenuItem.new(:label => "Fee Structure", :klass => "", :icon => "th", :href => "grade_wise_fees_path")
  end

end
