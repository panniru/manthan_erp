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
    "fee_reports" => "fee_management", 
    "admissions" => "enquiry_admission",
    "events" => "enquiry_admission",
    "staffs" => "enquiry_admission",
    "academics" => "academic",
    "teachers_time_tables" => "academic",
    "teaching_plans" => "academic",
    "teacher_grade_mappings" => "academic",
    "class_teacher_mappings" => "academic",
    "grades_sections_mappings" => "academic", 
    "grades_subjects_mappings" => "academic", 
    "assessment_types" => "academic",
    "assessment_criterias" => "academic",    
    "gradings" => "academic", 
    "assessments" => "academic",
    "assessment_results" => "academic",
    "academic_terms" => "academic",
    "term_results" => "academic",
    "subject_masters" => "academic",
    "section_masters" => "academic",
    "staffrecruits" => "recruitment_sub_menu",
    "recruitments" => "recruitment_sub_menu",
    "staff_admissions"=> "recruitment_sub_menu",
    "adds" => "recruitment_sub_menu",
    "teacher_leaders" => "enquiry_admission",
    "forms" => "recruitment_sub_menu",
    "admission_reports" => "enquiry_admission",
    "staff_reports" => "recruitment_sub_menu",
    "documentuploaders" => "recruitment_sub_menu",
    "interviewschedulers" => "recruitment_sub_menu",
    "staffadmins" => "recruitment_sub_menu",
    "statuses" => "enquiry_admission",
    "libraries" => "library",
    "books" => "library",
    "issuings" => "library",
    "damagebooks"=> "library",
    "block_books" => "library",
    "request_new_books" => "library",
    "donate_books" => "library",
    "lib_reports" => "library",
    "request_books" => "library",
    "request_books_admin" => "library",
    "grade_books" => "library",
    "default_masters" => "default_master_sub_menu",
    "student_masters" => "default_master_sub_menu",
    "time_tables" => "default_master_sub_menu",
    "parents" => "default_master_sub_menu",
    "holidaycalendars" => "default_master_sub_menu",
    "location_masters" => "transport",
    "new_vehicles" => "transport",
    "routes" => "transport",
    "student_route_mappings" => "transport",
    "special_day_transports" => "transport",
    "default_masters" => "default_master_sub_menu",
    "HRM" => "hrm_sub_menu",
    "canteen_managements" =>"canteen",
    "mealtypes" => "canteen",
    "mealnames" => "canteen",
    "inventories" => "canteen",
    "attendances" => "attendance_ctrl",
    "faculty_attendances" => "attendance_ctrl",
    "setup_masters" => "attendance_ctrl",
    "leave_permissions" => "attendance_ctrl",
    "guest_managements" => "hrm_sub_menu",
    "vendor_categories" => "default_master_sub_menu",
    "vendor_managements" => "hrm_sub_menu",
    "food_wastages" => "canteen",
    "non_academics" => "non_academic",
    "grades_activities_mappings" => "non_academic",
    "activity_teachers_mappings" => "non_academic",
    "na_assessment_criterias" => "non_academic",
    "na_assessments" => "non_academic",
    "na_assessment_results" => "non_academic",
    "lab_masters" => "lab",
    "lab_criterias" => "lab",
    "grade_lab_mappings" => "lab",
    "activity_masters" => "non_academic",
    "lab_masters" => "lab",
    "lab_teacher_mapping" => "lab",
    "designations" => "default_master_sub_menu",
    "faculty_masters" => "payroll_menu",
    "payslips" => "payroll_menu",
    "print_payslips" => "payroll_menu",
    "default_allowance_deductions" => "payroll_menu",
    "faculty_leaves" => "payroll_menu",
    "salary_break_ups" => "payroll_menu",
    "employer_pf_contributions" => "payroll_menu",
    "default_values" => "payroll_menu",
    "tax_buckets" => "payroll_menu",
    "designation_masters" => "payroll_menu",
    "pf_statements" => "payroll_menu",
    "form24" => "payroll_menu",
    "form24" => "payroll_menu",
    "salary_taxes" => "payroll_menu",
    "day_ends" => "default_master_sub_menu",
    "lab_teacher_mappings" => "lab",
    "lab_assessments" => "lab",
    "lab_subject_assessment_mappings" => "lab",
    "listings" => "lab",
    "lab_results" => "lab",
    "results" => "HrmSubMenu",
    "grading_defaults" => "default_master_sub_menu",
    "final_results" => "academic",
    "faculty_masters" => "HrmSubMenu",
    "school_houses" => "default_master_sub_menu", 
    "admin_dashboards" => "enquiry_admission",
  }
  
  def self.get_context(args)
    if args[:context].present?
      CONTEXT_CONTROLLER_MAPPER[args[:context]].present? ? CONTEXT_CONTROLLER_MAPPER[args[:context]].classify.constantize.new(:controller => args[:key], :params => args[:params]) : nil
    else
      CONTEXT_CONTROLLER_MAPPER[args[:key]].present? ? CONTEXT_CONTROLLER_MAPPER[args[:key]].classify.constantize.new(:controller =>args[:key], :params => args[:params]) : nil
    end
    
  end



  def self.mapped_module_name(key)
    CONTEXT_CONTROLLER_MAPPER[key].present? ? CONTEXT_CONTROLLER_MAPPER[key] : ""
  end
  
  
end
