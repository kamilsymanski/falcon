Falcon::Application.routes.draw do
  devise_for :account, :controllers => { :registrations => "account/registrations", :omniauth_callbacks => "account/omniauth_callbacks" }

  namespace :account do
    resource :profile, :only => [:show, :edit, :update]
    resource :language_settings, :only => [:edit, :update]

    resources :pictures do
      resources :comments
      resources :likes, :only => [:create]

      collection do
        post :upload
        post :apply_filter
      end
    end

    scope ":profile_id", :as => :view do
      resources :pictures, :only => [:index, :show]

      get "" => "profiles#show"
    end
  end

  devise_for :affiliate, :controllers => { :registrations => "affiliate/registrations" }

  namespace :affiliate do
    resource :business_profiles, :only => [:edit, :update]
    resource :language_settings, :only => [:edit, :update]
  end

  devise_for :admin

  namespace :admin do
    resource :profile, :only => [:edit, :update]

    resources :accounts
    resources :admins
    resources :affiliates

    root :to => "accounts#index"
  end

  get "home/index"

  root :to => "home#index"

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
