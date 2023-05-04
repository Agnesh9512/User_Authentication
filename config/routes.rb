# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  get '/manage_products/', to: 'products#manage'
  get 'checkout/:product_id', to: 'checkout#create', as: 'checkout_product_id'
  post '/checkout/create', to: 'checkout#create'
  # root 'products#index'
  devise_for :users
  resources :products
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
