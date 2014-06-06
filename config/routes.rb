ManthanErp::Application.routes.draw do
  resources :schedules
  resources :reports
  get 'auto_search/autocomplete_student_name'
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
  resources :levels
  resources :students
  resources :fee_types do
    collection do
      post "create_bulk"
    end
  end
  resources :fee_grade_buckets
  resources :term_definitions do
    collection do
      post "create_term"
    end
  end

  resources :grade_wise_fees do
    collection do
      get "grade_wise_fee_view"
      post "save_grade_wise_fee_grid"
    end
  end


  resources :term_wise_grade_fees do
    collection do
      get "term_wise_grade_fee"
      post "save_term_wise_fee_grid"
    end
  end

  
  resources :monthly_pdc_amounts  do
    collection do
      get "monthly_pdc_amounts"
      post "save_monthly_pdc_amounts"
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
