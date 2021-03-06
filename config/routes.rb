Rails.application.routes.draw do

  resources :users
  resources :microposts, only: [:create, :destroy, :index] do
      resources :comments
  end
  root 'static_pages#home'

  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  get 'login'   => 'sessions#new'
  post 'login'  => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  # See how all your routes lay out with "rake routes".
  #recipe page
  get 'recipe'    => 'recipes#recipe'
  get 'breakfast' => 'recipes#breakfast'
  get 'lunch' => 'recipes#lunch'
  get 'pasta' => 'recipes#pasta'
  get 'drink' => 'recipes#drink'
  get 'newrecipe' => 'recipes#newrecipe'
  get 'popularrecipe' => 'recipes#popularrecipe'
  get 'freshmaterial' => 'recipes#freshmaterial'
  get 'eggnog' => 'recipes#eggnog'
  get 'lemonchi' => 'recipes#lemonchi'
  get 'casserole' => 'recipes#casserole'
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  resources :users do
    member do
      get :following, :followers, :collecting
    end
  end

  resources :microposts do
    member do
      get :collecters
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :collections,         only: [:create, :destroy]

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
