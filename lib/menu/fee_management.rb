class FeeManagement
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << fee_types
    sub_menu << grade_buckets
    sub_menu << terms
    sub_menu << monthly_pdcs
    sub_menu << fee_structure
    sub_menu << payments
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
    MenuItem.new(:label => "Fee Types", :klass => "", :icon => "tasks", :href => "/fee_types" )
  end

  def grade_buckets
    MenuItem.new(:label => "Grade Buckets", :klass => "archive", :icon => "codepen", :href => "/fee_grade_buckets")
  end

  def terms
    MenuItem.new(:label => "Terms", :klass => "", :icon => "cubes", :href => "/term_definitions")
  end

  def monthly_pdcs
    MenuItem.new(:label => "Monthly PDCs", :klass => "", :icon => "calendar-o", :href => "/post_dated_cheques")
  end

  def fee_structure
    MenuItem.new(:label => "Fee Structure", :klass => "", :icon => "th", :href => "/grade_wise_fees")
  end

  def payments
    MenuItem.new(:label => "Pay Fee", :klass => "", :icon => "inr", :href => "/parent_payment_masters")
  end


end
