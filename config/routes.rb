Tcp::Application.routes.draw do
  resources :matrices do
    member do
      get :add, :action => 'add'
      get :feed, :action => 'feed'
      get :add_follower, :action => 'add_follower'
    end
  end

  resources :competences
  resources :industries
  resources :companies do
    collection do
      get :search, :action => 'search'
    end
    member do
      get :add_to_matrix, :action => 'add_to_matrix'
    end
  end
  
  resources :company_imports do
    collection do
      post :save_imported, :action => 'save_imported'
    end
  end
  resources :industry_imports
  resources :competence_imports
  
  
  match "dashboard" => "dashboard#index"
  match "testlinkedin" => "crawler#testlinkedin"
  match "crawl" => "crawler#crawl_suggested_companies"
  


  
  
  root :to => 'dashboard#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users, controllers:{omniauth_callbacks: "omniauth_callbacks"}
  ActiveAdmin.routes(self)


  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
