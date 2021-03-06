Rails.application.routes.draw do
  get 'profiles/show'
  ### Landing Page
  root 'welcome#index'
  get 'welcome/index'
  ########################################################################

  ### User Routes
  devise_for :users, controllers: { confirmations: 'confirmations' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  ########################################################################
  
  ### Prdoduct Routes
  get "/fetch_products" => 'products#filter_products', as: 'fetch_products'
  resources :products
  ########################################################################

  ### Cart Routes
  get 'carts', to: 'carts#index', as: 'carts'
  post 'add.to.cart/:id', to: 'carts#create', as: 'add_to_cart'
  put 'cart/:id', to: 'carts#update', as: 'cart'
  delete 'remove.product/:id', to: 'carts#remove', as: 'remove_product'
  delete 'remove.cart/:id', to: 'carts#destroy', as: 'remove_cart'
  ########################################################################

  ### Order Routes
  get 'orders', to: 'orders#index', as: 'orders'
  get 'order/:id/edit', to: 'orders#edit', as: 'edit_order'
  put 'order/:id', to: 'orders#update', as: 'order'
  ########################################################################

  ### Store_Orders Routes
  get 'store.orders', to: 'store_orders#index', as: 'store_orders'
  get 'store.history', to: 'store_orders#history', as: 'store_history'
  put 'store.response/:id', to: 'store_orders#update', as: 'store_response'
  ########################################################################
  
  ### Reviews Routes
  post "rate.product/:id" => 'reviews#rate', as: 'rate_product'
  post "comment.product/:id" => 'reviews#comment', as: 'comment_product'
  ########################################################################
  
  ### Profile Routes
  get 'profile/:id', to: 'profiles#show', as: 'profile'
  ########################################################################

  #Product API Routes
  namespace :api do
    resources :products
  end

end
