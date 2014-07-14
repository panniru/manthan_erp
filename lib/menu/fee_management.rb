class FeeManagement < Struct.new(:controller)
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << fee_types
    sub_menu << grade_buckets
    sub_menu << terms
    sub_menu << monthly_pdcs
    sub_menu << fee_structure
    sub_menu << payments
    sub_menu << cheques
    sub_menu << mailings
    sub_menu << approvals
    sub_menu << admin_transactions
    sub_menu << reports
    sub_menu
  end

  def parent_sub_menu
    sub_menu = []
    sub_menu << fee_structure
    sub_menu << payments
    #sub_menu << cheques
    sub_menu << parent_transactions
    sub_menu
  end
  
  def accountant_sub_menu
    sub_menu = []
    sub_menu << fee_structure
    sub_menu << payments
    sub_menu << cheques
    sub_menu << mailings
    sub_menu
  end

  def teacher_sub_menu
    []
  end

  private

  def fee_types
    MenuItem.new(:label => "Fee Types", :klass => controller == "fee_types" ? "active" : "", :icon => "tasks", :href => "/fee_types" )
  end

  def grade_buckets
    MenuItem.new(:label => "Grade Buckets", :klass => controller == "fee_grade_buckets" ? "active" : "", :icon => "codepen", :href => "/fee_grade_buckets")
  end

  def terms
    MenuItem.new(:label => "Terms", :klass => controller == "term_definitions" ? "active" : "", :icon => "cubes", :href => "/term_definitions")
  end

  def monthly_pdcs
    MenuItem.new(:label => "Monthly PDCs", :klass => controller == "post_dated_cheques" ? "active" : "", :icon => "calendar-o", :href => "/post_dated_cheques")
  end

  def fee_structure
    MenuItem.new(:label => "Fee Structure", :klass => controller == "grade_wise_fees" ? "active" : "", :icon => "th", :href => "/grade_wise_fees")
  end

  def payments
    MenuItem.new(:label => "Pay Fee", :klass => controller == "parent_payment_masters" ? "active" : "", :icon => "inr", :href => "/parent_payment_masters")
  end

  def cheques
    MenuItem.new(:label => "Cheques", :klass => controller == "parent_cheques" ? "active" : "", :icon => "money", :href => "/parent_cheques")
  end

  def mailings
    MenuItem.new(:label => "Mailing Jobs", :klass => controller == "job_runs" ? "active" : "", :icon => "envelope-o", :href => "/job_runs")
  end
  
  def approvals
    MenuItem.new(:label => "Approvals", :klass => controller == "approval_items" ? "active" : "", :icon => "check", :href => "/approval_items")
  end
  
  def parent_transactions
    MenuItem.new(:label => "Transactions", :klass => controller == "parent_payment_transactions" ? "active" : "", :icon => "suitcase", :href => "/parent_payment_transactions/parent_transactions")
  end
  
  def admin_transactions
    MenuItem.new(:label => "Transactions", :klass => controller == "parent_payment_transactions" ? "active" : "", :icon => "suitcase", :href => "/parent_payment_transactions/admin_transactions")
  end
  
  def reports
    MenuItem.new(:label => "Reports", :klass => controller == "fee_reports" ? "active" : "", :icon => "file-photo-o", :href => "/fee_reports")
  end
  
  def method_missing(meth, *args, &block)
    []
  end
  
end
