class ContextDetector
  CONTEXT_CONTROLLER_MAPPER = {
    "fee_types" => "fee_management",
    "fee_grade_buckets" => "fee_management",
    "term_definitions" => "fee_management",
    "post_dated_cheques" => "fee_management",
    "grade_wise_fees" => "fee_management",
    "parent_payment_masters" => "fee_management",
    "parent_cheques" => "fee_management",
    "term_wise_grade_fees" =>"fee_management",
    "monthly_pdc_amounts" =>"fee_management",
    "approval_items" =>"fee_management", 
    "home" => "fee_management",
    "job_runs" => "fee_management",
    "parent_payment_transactions" => "fee_management", 
    "admissions" => "enquiry_admission",
    "events" => "enquiry_admission",
    "staffs" => "enquiry_admission",
    "academics" => "academic",
    "time_tables" => "academic",
    "teachers_time_tables" => "academic",
    "teaching_plans" => "academic",
    "teacher_grade_mappings" => "academic",
    "class_teacher_mappings" => "academic",
    "recruitments" => "recruitment_sub_menu",
    "adds" => "recruitment_sub_menu",
    "forms" => "recruitment_sub_menu",
    "documentuploaders" => "recruitment_sub_menu",
    "interviewschedulers" => "recruitment_sub_menu",
    "#" => "recruitment_sub_menu",
    "#" => "recruitment_sub_menu",
    "#" => "recruitment_sub_menu",
    "books" => "library",
    "issuings" => "library",
    "default_masters" => "default_master_sub_menu",
    "student_masters" => "default_master_sub_menu",
    "parents" => "default_master_sub_menu"
  }
  
  def self.get_context(key)
    CONTEXT_CONTROLLER_MAPPER[key].present? ? CONTEXT_CONTROLLER_MAPPER[key].classify.constantize.new(key) : nil
  end



  def self.mapped_module_name(key)
    CONTEXT_CONTROLLER_MAPPER[key].present? ? CONTEXT_CONTROLLER_MAPPER[key] : ""
  end
  
  
end
