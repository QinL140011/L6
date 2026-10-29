Rails.application.routes.draw do
  resources :products
  resources :cartitems
  resources :carts

  get 'top/main' => 'top#main'
  root 'top#main'
end