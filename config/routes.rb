# frozen_string_literal: true

Rails.application.routes.draw do
  resources :landlords
  resources :tenants
  resources :users

  resources :property_landlords, only: %i[update create] do
    get 'new' => 'property_landlords#new', on: :member
    get 'remove_owner' => 'property_landlords#destroy', on: :member
  end

  resources :property_tenants do
    get 'new' => 'property_tenants#new', on: :member
    get 'unrent' => 'property_tenants#unrent', on: :member
  end

  resources :properties do
    get 'advertised_monthly_rent' => 'properties#advertised_monthly_rent', on: :collection
    get 'tenancy_rent_record' => 'properties#tenancy_rent_record', on: :collection
  end

  controller :sessions do
    get 'login' => :new, as: :login
    post 'login' => :create
    delete 'logout' => :destroy, as: :logout
  end

  root 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
