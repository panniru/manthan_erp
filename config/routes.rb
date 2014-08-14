ManthanErp::Application.routes.draw do
 


  get "student_route_mappings/index"
  get "student_route_mappings/create"
  get "student_route_mappings/show"

  get "new_vehicles/index"
  get "new_vehicles/show"
  get "new_vehicles/edit"
  get "new_vehicles/new"

 
 
  get "teaching_plans/new"
  get "teaching_plans/edit"
  get "teaching_plans/index"
  get "teaching_plans/show"
  resources :donation_of_books do
    collection do
      get 'gradeserviceview'
      get 'sectionserviceview'
      end
    end
  
  resources :student_route_mappings do
    collection do
      get "get_route_view"
    end
  end
  
  resources :interviewschedulers do
    member do
      get 'home_index'
    end
  end
  resources :block_books do
    collection do
      get 'get_book_service_view'
      get 'getbooks'
      post 'savebooks'
      post 'damagebooks'
      
    end
  end 
 
  resources :request_new_books do
    collection do
      get 'request_new'
      get 'request_approval'
      post 'create_bulk'
      get 'request_new_book'
      get 'request_accept'
      get 'suggest_teacher'
      get 'book_accept'
      get 'book_reject'
     
    end
     member do
      get 'home_request_approval'
      get 'book_request_approval'
      get 'bookrequest'
  end
  end
  resources :issuings do
    collection do
      get "student_book_issuings"
      get 'gradeserviceview'
      get 'sectionserviceview'
    end
  end
  resources :damagebooks do
    collection do
      get 'get_book_service_view'
     post 'damagebooks'
    end
  end 
  resources :staffs
  get "staffs/staffview"

  devise_for :users, :controllers => { :sessions => 'sessions'}
 
  get 'auto_search/student_name_by_grade_and_section'
  get 'auto_search/autocomplete_book_isbn'
  get 'auto_search/autocomplete_staff_grade'
  get "time_tables/gradeserviceview"
  get "time_tables/sectionserviceview"
  get "/time_tables/subjectserviceview"
  post "/time_tables/saveperiods"
  get "/time_tables/timetableserviceview"
  post "/time_tables/getperiods"
  get "/time_tables/getperiods"
  get "/time_tables/defaultperiodsserviceview"
  post "/time_tables/checktimetable"
  get "/time_tables/checktimetable"

  #get "/teaching_plans/gradeserviceview"
  #get "/teaching_plans/sectionserviceview"

  resources :time_tables  
  resources :books do 
    collection do 
      get  'home_index'
      post 'create_bulk'
    end
  end
  resources :teaching_plans do
     collection do
      get "calendardata"
      get "getfacultyidservice"
      get "getgradessectionsservice"      
      get 'calendarpopup'
      get 'monthlywiseplan'
      get 'get_grade_section_subject_service'
      get 'teaching_date'
      get 'getmonthlycalendarservice'
      get 'getmonthdataservice'
      get "student_teaching_plans"
      get 'getfacultydatesservice' 
      get 'plan_exists' 

    end
  end

  resources :documentuploaders do
    member do
      get 'home_index'
    end
  end
  
  resources :new_vehicles 
  
 resources :forms do
    member do
      get 'home_index'
    end
  end

  resources :discounts 
  resources :approval_items do
    member do
      put "approve"
      put "reject"
    end
    collection do
      get "fee_structure_approval_item"
    end
  end
  resources :events

  resources :fee_types do
    collection do
      post "create_bulk"
    end
  end
  resources :fee_grade_buckets do
    collection do
      post "create_bulk"
      get "all_grades"
    end
  end
  resources :term_definitions do
    collection do
      post "create_bulk"
    end
  end
  
  resources :grade_wise_fees do
    collection do
      get "grade_wise_fee_view"
      post "save_grade_wise_fee_grid"
      get "grade_wise_fee_of_student"
    end
  end


  resources :term_wise_grade_fees do
    collection do
      get "term_wise_grade_fee"
      post "save_term_wise_fee_grid"
      get "term_wise_fee_of_student"
    end
  end

  
  resources :monthly_pdc_amounts  do
    collection do
      get "monthly_pdc_amounts"
      post "save_monthly_pdc_amounts"
      get "month_wise_fee_of_student"
    end
  end


  resources :post_dated_cheques do
    collection do
      post "create_bulk"
    end
  end
  
  get "fee_alerts/fee_struct_mail_to_parents" 

  resources :student_masters do
    collection do
      get "belongs_to_parent"
      get "new_upload"
      post "upload"
    end
    member do
      get 'monthly_pdcs'
      get 'next_term_fee'
      get "annual_discount_details"
      get "dashboard"
      put "update_address"
    end
  end
  
  resources :parent_payment_masters do
    collection do
      get "pay"
      get "transaction_types"
    end
    member do
      get "pending_pdcs"
      get "cleared_pdcs"
      get "payment_transactions"
      get "submitted_pdcs"
    end
    resources :parent_payment_transactions do
      member do
        get "print"
        
      end
    end
  end
  
  resources :routes do
    collection do
      post "create_bulk"
      get "get_location_view"
      post "send_mail"
    end
  end
  
  resources :staffs do
    member do
      get 'event_new'
    end
    collection do
      get 'event_index'
      get 'staffs/staffview'
    end
  end

  resources :parent_cheques

  resources :job_runs do
    member do
      get "failure_recipients"
    end
  end
  
  resources :default_masters
  
  resources :academics

  resources :teachers_time_tables do
    collection do
      get "get_faculty_names_view"
      get "get_faculty_garde_sections_view"
      get "check_teachers_timetable"
      post "saveperiods"
      post "getperiods"
    end  
  end

  resources :teacher_grade_mappings do
    collection do
      get "check_teachers_grades_mapping"
      post "savemappings"
      post "getmappings" 
      post "deletemappings"  
      get "show_grade_wise"
      get "get_grade_wise_mappings"   
      end
  end
  
  get "/parent_payment_transactions/parent_transactions"
  get "/parent_payment_transactions/admin_transactions"

  resources :grade_masters do
    resources :section_masters
  end

  resources :parents do
    collection do
      get "new_upload"
      post "upload"
    end
  end

  resources :class_teacher_mappings do
    collection do
      get "get_grade_wise_mappings"
      get "get_grade_wise_faculty_names"  
      get "get_class_teacher_mappings" 
      post "save_mappings"
      post "deletemappings"
      get "check_for_teacher_mapping"
    end  
  end

  resources :grades_sections_mappings do
    collection do
      post "save_sections_mappings"           
    end  
  end

  resources :grades_subjects_mappings do
    collection do
      get "get_grades_subjects_service_view"
      post "save_subjects_mappings"     
    end  
  end
  get "/assessment_criterias/sample"
  
  resources :assessment_criterias do
    collection do
    get "get_assessment_criteria_service"    
    end
  end

  resources :gradings do
    collection do
    get "get_grading_service_view"
    post "save_gradings_mappings"
    post "delete_grading_mappings"
    end
  end
  
  resources :location_masters

  resources :new_vehicles

  resources :recruitments do
    member do
      put 'update_admission'
      get "homeindex"
      get "view_document"
      get 'create_enquiry'
      get "document_verification"
      get 'view_assessment'
      get 'assessment_result'
      put 'update_rec'
      put 'update_ass'
      put 'update_man'
      put 'update_close'
      get 'assessment_new'
    end
    collection do
      
      get 'recruitment_home'
      get 'get_subject_view'
      get 'get_klass_view'
      get 'enquiry_new'
      post 'create_enquiry'
      get 'document_index'
      get 'sports_index'
      get 'assessment_index'
      get 'assessment_completed_index'
      get 'management_index'
      get 'selected_staffs'
      get 'closed_forms'
    end
  end
  resources :staff_admissions do
    member do
      get 'homeindex'
      get "document_verification"
      post 'update_close'
      put 'update_admission'
      put 'update_man'
    end
    collection do
      get 'get_head_view'
      get 'get_post_view'
      get 'get_subject_view'
      get 'get_klass_view'
      get 'enquiry_index'
     
    end
  end
  
  resources :teacher_leaders
  
  resources :adds do 
    collection do
      get 'get_dept_view'
    end
  end
 
  resources :assessment_criterias do
    collection do
      get "get_assessment_criteria_service"       
      post "save_assessment_criterias"
      post "deletemappings"
    end
  end

  resources :gradings do
    collection do
    get "get_grading_service_view"
    post "save_gradings_mappings"
    post "delete_grading_mappings"
    end
  end

    resources :assessment_criterias do
      collection do
        get "get_assessment_criteria_service"  
      end  
    end
    

   resources :staff_admissions do
    resources :recruitments
  end
  
  resources :staffadmins

  get "/fee_reports", to: "fee_reports#index"
  get "/fee_reports/payment_status_report", to: "fee_reports#payment_status_report"
  get "/fee_reports/payment_type_details", to: "fee_reports#payment_type_details"
  root to: "home#index"

  resources :assessments do
    collection do
      get "get_assessment_types_service"
      post "delete_assessment_type_mappings"
      post "save_assessment_type_mappings"
      get "get_assessment_grade_mappings_service"
      post "save_assessment_grade_mappings"
      get"get_teacher_assessments_service"
      get "get_teacher_grade_mappings"
      post "save_teacher_assessments"
      post "delete_teacher_assessment_mappings"
      get "get_assessment_mappings_service"
    end  
  end
  
  resources :admissions do
    member do
      get 'enquiry_show'
      get 'admission_show'
      get 'admission_new'
      get 'assessment_new'
      get 'assessment_show'
      get 'home_index'
      get 'edit_application'
      get 'edit_assessment'
      get 'edit_assessment_result'
      post "admissions/update_enquiry"
      post "admissions/update_assessment"
      put 'update_admission'
      get 'view_assessment'
      get 'assessment_result'
      get 'management_result'
      get 'time_table'
    end
    
    collection do
      get "enquiry_index"
      get "admission_index"
      get "assessment_index"
      get "assessment_completed"
      get 'management_index'
      get "enquiry_new"
      get 'admission_home'
      get 'closed_forms'
      get 'calendar'
      get "get_klass_view"
      get "get_details"
      get "selected_students"
      
      
    end
  end
  


  resources :assessment_results do   
    collection do
   end  
  end      

end
