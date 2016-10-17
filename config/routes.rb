Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :categories
  resources :products
  resources :basket, only: [:index, :update]
  resources :orders, :except => [:edit, :update,:destroy]


  match ':controller(/:action(/:id))', :via => 'get' 

  root 'categories#index'
end
