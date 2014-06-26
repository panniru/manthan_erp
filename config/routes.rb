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
  resources :fee_structure_approvals 
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
    member do
      get 'monthly_pdcs'
      get 'next_term_fee'
      get "annual_discount_details"
    end
  end

  resources :parent_payment_masters do
    collection do
      get "pay"
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
     
    end

    collection do
      get "enquiry_index"
      get "admission_index"
      get "enquiry_new"
      get "event_index"
      get 'admission_home'
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
  
end
