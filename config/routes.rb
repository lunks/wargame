Rpg::Application.routes.draw do
   devise_for :users

   resources :squads do
     member do
       get :goal
       get :transfer
     end
   end

   resources :tradeports

   resources :generic_units do
     collection do
       get :move
     end
   end

   resources :facilities do
     member do
       get :buy
     end
   end

   resources :planets, :shallow => true do
     resources :facility_fleets
     member do
       get :move
     end
     collection do
       get :map
     end
     resources :results do
       member do
         get :show_results
         get :show_fog
       end
     end
 
   end

   resources :generic_fleets do
     member do
       put :move
       put :move_facility
       get :sensor
     end
   end

   resources :capital_ships do
     member do
       put :load_in
       put :unload_from
     end
   end

   resources :light_transports do
     member do
       put :load_in
       put :unload_from
     end
   end

   resources :fighters do
     member do
       put :arm
       put :disarm
     end
   end

   resources :sensors

   match 'ready' => 'squads#ready'
   match 'index' => 'home#index'
   match 'fleets' => 'generic_fleets#index'
   match 'transfer' => 'squads#transfer'
   match 'close_popup' => 'home#close_popup'
   match 'back_to_main' => 'generic_fleets#back_to_main'

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
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.

  match ':controller(/:action(/:id(.:format)))'
end
