ManthanErp::Application.routes.draw do

  devise_for :users, :controllers => { :sessions => 'sessions'}

  get 'auto_search/autocomplete_student_name'
  get 'auto_search/student_name_by_grade_and_section'

  get "students/app"
  get "students/app_students"
  get "students/get_selected"
  get "students/enquiry"
  get "students/more"
  get "students/index"
  get "students/new"
  get "students/show"
  get "students/edit"
  get "home/aboutus"

  root to: "home#index"

  resources :students

  resources :fee_types do
    collection do
      post "create_bulk"
    end
  end
  resources :fee_grade_buckets do
    collection do
      post "create_bulk"
    end
  end
  resources :term_definitions do
    collection do
      post "create_term"
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

  resources :student_hrs do
    member do
      get 'monthly_pdcs'
      get 'next_term_fee'
    end
  end

  resources :parent_payment_masters do
    collection do
      get "pay"
      
    end
    member do
      get "submitted_pdcs"
      get "cleared_pdcs"
      get "payment_transactions"
    end
  end

  resources :discounts 
  resources :fee_structure_approvals 


end
