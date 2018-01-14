Rails.application.routes.draw do
  root 'products#index'

  post '/orders/:id',  to: 'orders#change_order_status'

  resources :customers
  resources :products
  resources :orders
end
