FlowShare::Application.routes.draw do

  devise_for :users, controllers: {
    registrations: "registrations"
#    confirmations: "confirmations"
  }

  root "welcome#index"

  get '/app' => "base#app"
  get '/flows', to: redirect("/app")


  namespace :api do
    resources :flows, only: [:create, :update, :destroy, :index, :show] do
      resources :steps, only: [:create, :update, :destroy, :complete] do
        get 'complete', on: :member
      end

      resources :flow_accesses, only: [:create, :destroy, :show]
    end

    resources :users, only: [:search] do
      get 'search', on: :collection
    end
  end

  get '/validate_email' => "welcome#validate_email"

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
