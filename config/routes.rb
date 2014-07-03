ManthanErp::Application.routes.draw do
  get "teaching_plans/new"
  get "teaching_plans/edit"
  get "teaching_plans/index"
  get "teaching_plans/show"
  resources :interviewschedulers

  resources :staffs
  get "staffs/staffview"

  devise_for :users, :controllers => { :sessions => 'sessions'}
 
  get 'auto_search/student_name_by_grade_and_section'
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

  get "/teaching_plans/gradeserviceview"
  get "/teaching_plans/sectionserviceview"
 

  root to: "home#index"


  resources :time_tables  

  resources :teaching_plans

  resources :documentuploaders
  resources :adds
  resources :forms
  resources :recruitments
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
    end
    member do
      get 'monthly_pdcs'
      get 'next_term_fee'
      get "annual_discount_details"
  
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

 
  resources :admissions do
    member do
      get 'enquiry_show'
      get 'admission_show'
      get 'admission_new'
      get 'event_new'    
      get 'event_show'
      get 'home_index'
      put 'update_admission'
      
    end

    collection do
      get "enquiry_index"
      get "admission_index"
      get "enquiry_new"
      get "event_index"
      get 'admission_home'
      get 'closed_forms'
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
      end
  end
  
  get "/parent_payment_transactions/parent_transactions"
end
