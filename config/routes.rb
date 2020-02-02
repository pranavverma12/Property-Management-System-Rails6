# frozen_string_literal: true

Rails.application.routes.draw do
  resources :landlords
  resources :tenants
  resources :users

  resources :properties do
    get 'unrent' => 'properties#unrent', on: :member
  end

  controller :sessions do
    get 'login' => :new, as: :login
    post 'login' => :create
    delete 'logout' => :destroy, as: :logout
  end

  root 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
