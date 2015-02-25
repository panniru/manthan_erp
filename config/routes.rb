ManthanErp::Application.routes.draw do


  resources :grade_lab_mappings do
    collection do
      get :all_subjects
    end
  end

  resources :vendor_managements do
    collection do
      get "get_vendor_view"
    end
  end

  resources :guest_managements do
    collection do
      get "get_role_view"
    end
  end


  resources :food_wastages do
    collection do
      get "get_food_wastage"
    end
  end
  

  get "teaching_plans/new"
  get "teaching_plans/edit"
  get "teaching_plans/index"
  get "teaching_plans/show"
  resources :lib_reports do
    collection do
      get 'Leastused'
      get 'popup'
      end
    end
  resources :donation_of_books do
    collection do
      get 'gradeserviceview'
      get 'sectionserviceview'
      end
    end
  
  resources :student_route_mappings do
    collection do
      get "get_search_students"
      get "get_up_route_view"
      get "get_down_route_view"
      get "get_student_view"
      post "save_route"
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
      get 'grade_section_service'
    end
  end
  resources :damagebooks do
    collection do
      get 'get_book_service_view'
      post 'damagebooks'
      get 'get_damage_books'
    end
  end 
  resources :staffs
  get "staffs/staffview"

  devise_for :users, :controllers => { :sessions => 'sessions'}
  
  get 'auto_search/autocomplete_location_master_location_name'
  get 'auto_search/autocomplete_student_master_name'
  get 'auto_search/autocomplete_faculty_master_faculty_name'
  get 'auto_search/student_name_by_grade_and_section'
  get 'auto_search/autocomplete_book_isbn'
  get 'auto_search/autocomplete_staff_grade'
  get 'auto_search/autocomplete_user_email'
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

  resources :time_tables do
    collection do       
      get "get_sections_for_grade"
      get "get_subjects_for_grade"
    end 
  end 

  resources :books do 
    member do 
    end
    collection do       
      post 'create_bulk'
      post 'add_bulk'
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
  
  resources :new_vehicles do
    collection do
      get 'get_vendor_name'
    end
  end
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
      delete "destroy_all"
    end
  end
  resources :term_definitions do
    collection do
      post "create_bulk"
      delete "destroy_all"
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
      delete "destroy_all"
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
      get "attendance_calendar_for_month"
      get "student_summarized_monthly_report"
      get "transport_details"
      put "change_transport"
    end
  end
  
  resources :parent_payment_masters do
    collection do
      get "pay"
      get "transaction_types"
      get "student_transactions"
    end
    member do
      get "pending_pdcs"
      get "cleared_pdcs"
      get "payment_transactions"
      get "submitted_pdcs"
      get "print"
    end
  end
  resources :parent_payment_transactions do
    member do
      get "print"
      get "in_detail"
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
  
  resources :academics do
    collection do
      get "get_grades"
      get "get_academics_subjects"
      get "get_sections_for_grade"
      get "get_academics_subjects_for_grade"
    end
  end


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
    member do
      get "sections"
    end
    resources :section_masters
  end

  resources :parent_masters do
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
      get "get_grades_sections_service_view"
      post "save_sections_mappings" 
      post "save_grades_mappings"         
    end  
  end

  resources :grades_subjects_mappings do
    collection do
      get "get_grades_subjects_service_view"
      post "save_subjects_mappings" 
      post "save_grades_mappings"    
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
      get "get_grade_subject_service"
      get "get_assessment_criteria"
    end
  end

  resources :gradings do
    collection do
    get "get_grading_service_view"
    post "save_gradings_mappings"
    post "delete_grading_mappings"
    end
  end      
  
  resources :staff_admissions do
    resources :recruitments
  end
  
  resources :staffadmins do
    collection do
      get 'get_faculty_names'
      get 'get_role_and_head' 
    end
  end
  resources :admission_reports do
    collection do
      get "get_admissions_on_status"
      get 'get_status_view'
    end
  end
  resources :staff_reports do
    collection do
      get "get_staffrecruits_on_status"
      get 'get_status_view'
    end
  end


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
      get 'close_index'
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
      get 'admin_management_index'
      get 'assess_completed_index'
      get 'assess_index'
      get 'get_close_status'
      get 'get_assessment_students'
      get "get_status_view"
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
  
  resources :routes do
    collection do
      post "create_bulk"
      get "get_location_view"
      get "get_bus_no_up"
      get "get_bus_no_down"
      get "all_students"
      post "send_mail"
      get 'all_locations'

    end
    member do
      get 'locations'
      get "students"
      get "get_route_locations"
    end
  end
  
  resources :assessment_results do   
    collection do
      get "get_teacher_assessments_service"
      get "get_student_details_service"
      post "save_assessment_results_service"
      get "get_assessment_results_service"
      get "get_assessments_service"
   end  
  end      

  resources :canteen_managements do
    collection do
      post 'create_bulk'
      #get "canteenmanagerview"
      get "home_index"
    end
  end

  resources :mealtypes do
    collection do
      post 'create_bulk'
      #get "canteenmanagerview"
      get "home_index"
    end
  end
  resources :mealnames do
    collection do
      get "canteenmanagerdata"
      get "canteen_date"
      get  "getmealtypeidservice"
      post "create_bulk"
      get "get_meal_names"
    end
  end

  resources :inventories do
    collection do
      get "ordered_inventory"
      get "get_inventory_view"
      post "mail_to_vendors"
      post "update_inventory_status"
      post 'create_bulk'
      get 'get_canteen_vendors'
    end
  end


  resources :canteenmanagers do
    collection do
      get "canteenmanagerdata"
      get "canteen_date"
    end
  end

  resources :special_day_transports do
    # member do
    #   get 'occations'
    # end
    collection do
      post 'create_bulk'
      get 'send_mail'
      get 'occations'
    end
  end

  resources :holidaycalendars do
    collection do
      get  "holidaycalendardata"
      get "holiday_date"
      get "empty"
    end
  end
  
  resources :staffrecruits do
    member do
      get 'close_index'
      get 'recruited_form'
      get 'edit_assessment'
      get 'edit_document'
      get 'edit_enquiry'
      get 'enquiry_show'
      get 'upload_document'
      put 'update_admission'
      get "homeindex"
      get "document_verification"
      get 'view_assessment'
      get 'assessment_result'
      get 'management_result'
      get 'update_admission'
    end
    collection do
      get 'recruitment_home'
      get 'admin_management_index'
      get 'assess_completed_index'
      get 'assess_index'
      get 'get_staff_assessment'
      get 'get_assessment_staff'
      get 'reports'
      get 'get_subject_view'
      get 'get_klass_view'
      get 'get_head_view'
      get 'get_post_view'
      get 'enquiry_index'
      get 'document_index'
      get 'assessment_index'
      get 'assessment_completed_index'
      get 'management_index'
      get 'selected_staffs'
      get 'closed_forms'
      
      end
    end
  

  resources :academic_terms do   
    collection do
      get 'get_academic_terms_service'
      post 'save_academic_terms'
      post 'delete_academic_terms'
    end  
  end    

  resources :term_results do   
    collection do
      get 'term_results_mail_to_teachers'
      get 'get_term_results'
      get 'get_student_details'
      get 'get_subject_assessment_criteria'
      post 'save_term_results'
      get 'get_grades_sections'
      get 'get_grade_subjects'
      get 'get_student_term_results'
      get 'teacher_index'
      get 'principal_index'
      get 'class_teacher_show'
    end  
  end

  resources :libraries do   
    collection do
    end  
  end


  resources :request_books do 
    collection do
      get 'pending_request_books'
      post 'update_request_books_status'
      get 'request_books_mail_to_vendors'
      post 'request_books_mail_to_vendors'
      get 'delivered_request_books'
      get 'get_books_vendors'
    end  
  end

  resources :attendances do
    collection do
      get 'teacher_index'
      get 'get_students'
      get 'holidaycalendardata'
      get 'holiday_date'
      post 'save_student_attendance'
      get 'getStudentAndAttendanceView'
      get 'attendance_date'
      get 'week'
      get 'attendance_on_date'
    end
  end

  resources :donate_books do
    collection do
      get  'get_grades'
      get 'get_grade_sections'
      get 'get_students'
      post 'update_donate_book'
      post 'delete_donate_book'
    end
  end
  
  resources :subject_masters do
    collection do
      post 'create_bulk'     
    end      
  end

  resources :section_masters do
     collection do
      post 'create_bulk'     
    end    
  end
  resources :vendor_categories
 
  resources :faculty_masters do
    member do
      get "dashboard"
    end
  end
  resources :statuses

  resources :vendor_categories
  
  resources :student_route_mappings do
    collection do
      get "get_search_students"
      get "get_up_route_view"
      get "get_down_route_view"
      get "get_student_view"
      post "save_route"
    end
  end

  resources :communication_mails do
    collection do
      post "send_mail"
      get "unread"
    end
    member do
      get "mail_detail"
      post "reply"
      put "mark_as_read"
    end
  end

  resources :lab_masters 

  resources :grade_books do 
    collection do
      get "get_grades_service"
      get "get_grade_books_service"
      post "save_grade_books_service"
    end
  end
  
  resources :lab_criterias do
    collection do
      get :get_lab_masters
      get :all_grades
      post :save_assessment_criterias
      get :get_assessment_criteria
      post :deletemappings
    end
  end
  
  resources :non_academics do
    collection do
      post 'create_bulk'    
      get 'get_non_academics_subjects' 
    end      
  end

  resources :activity_masters do
    collection do
      post 'create_bulk'     
    end      
  end

   resources :grades_activities_mappings do
    collection do
      get "get_grade_activities"
      post "save_grade_activities_mappings"
      get  "get_activities"   
    end  
  end 

  resources :activity_teachers_mappings do
    collection do
      post "getmappings"   
      post "savemappings"   
      post "deletemapping"
      get "check_activity_teachers_mapping"
    end  
  end 

  resources :na_assessment_criterias do
    collection do
      get "get_assessment_criteria_service"  
      post "save_assessment_criterias" 
      post "deletemappings" 
    end  
  end 

  resources :na_assessments do
    collection do

    end
  end

  resources :na_assessment_results do
    collection do
      
    end
  end

end
