Rails.application.routes.draw do
  namespace :admin do
    get 'orders/index'
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :categories
  resources :products
  resources :basket, only: [:index, :update]
  resources :orders, :except => [:edit, :update,:destroy]


  match ':controller(/:action(/:id))', :via => 'get' 

  namespace :admin do
    get '', to: 'orders#index', as: '/'
    resources :orders, :except => [:destroy]
  end

  root 'categories#index'
end
