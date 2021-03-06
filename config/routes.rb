Rails.application.routes.draw do
  resources :workhours
  resources :works
  resources :visits do
    get 'toggle_confirm', :on => :member
    get 'book', :on => :member
  end

  get 'doctor_visits' => 'visits#index_visits_for_doctor'

  root 'welcome#index'

  get 'book_in_clinic' => 'visits#new_first_clinic'
  post 'book_in_clinic_create' => 'visits#create_first_clinic'

  get 'book_to_doctor' => 'visits#new_first_doctor'
  post 'book_to_doctor_create' => 'visits#create_first_doctor'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  
  resources :users do  
    get 'toggle_approve', :on => :member
  end
  
  resources :clinics

  get 'works/form/update_clinics' => 'works#update_clinics'
  get 'visits/form/update_visits' => 'visits#update_visits'


  get 'users/admin/doctors' => 'users#index_doctors'

  get  'users/admin/admin_new' => 'users#admin_new'
  post 'users/admin/admin_create' => 'users#admin_create'

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
