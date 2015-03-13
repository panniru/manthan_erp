class PayrollMenu
  def initialize(args)
    @controller = args[:controller]
  end
  
  def admin_sub_menu
    sub_menu = []
    sub_menu << faculty_upload
    sub_menu << payslips
    sub_menu << print_payslips
    sub_menu << default_allowances
    sub_menu << faculty_leaves
    sub_menu << salary_breakups_view
    sub_menu << employer_pf_contibutions
    sub_menu << default_values
    sub_menu << income_taxes
    sub_menu << mappings
    sub_menu << pf_statements
    sub_menu << annexure_1
    sub_menu << annexure_2 
  end
  
  private
  
  def faculty_upload
    MenuItem.new(:label => "Faculty", :klass => "", :icon => "arrow right ", :href => "/faculty_masters")
  end
  def payslips
    MenuItem.new(:label => "Payslips", :klass => "", :icon => "arrow right ", :href => "/payslips")
  end
  def print_payslips
    MenuItem.new(:label => "Email & Print Payslips", :klass => "", :icon => "arrow right ", :href => "/payslips/new_email_payslips")
  end
  def default_allowances
    MenuItem.new(:label => "Default Allowances&Deductions" ,:klass => "", :icon => "arrow right ", :href => "/default_allowance_deductions")
  end
  def faculty_leaves
    MenuItem.new(:label => "Faculty Leaves" ,:klass => "", :icon => "arrow right ", :href => "/faculty_leaves")
  end
  def salary_breakups_view
    MenuItem.new(:label => "Salary Breakups" ,:klass => "", :icon => "arrow right ", :href => "/salary_break_ups?type=salary")
  end
  def employer_pf_contibutions
    MenuItem.new(:label => "Employer PF Contibutions" ,:klass => "", :icon => "arrow right ", :href => "/salary_break_ups?type=pf")
  end
  def default_values
    MenuItem.new(:label => "Default Values" ,:klass => "", :icon => "arrow right ", :href => "/salary_break_ups?type=default")
  end
  def income_taxes
    MenuItem.new(:label => "Income Tax" ,:klass => "", :icon => "arrow right ", :href => "/tax_buckets")
  end
  def mappings
    MenuItem.new(:label => "Mappings" ,:klass => "", :icon => "arrow right ", :href => "/designation_masters")
  end
  def pf_statements
    MenuItem.new(:label => "PF statements" ,:klass => "", :icon => "arrow right ", :href => "/pf_statements/list_jobs")
  end
  def annexure_1
    MenuItem.new(:label => "Annexure 1" ,:klass => "", :icon => "arrow right ", :href => "/form24")
  end
  def annexure_2
    MenuItem.new(:label => "Annexure 2" ,:klass => "", :icon => "arrow right ", :href => "/form24/annexure")
  end
 
end

  
