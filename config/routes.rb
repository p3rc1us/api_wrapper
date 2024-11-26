# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'pages#index'

  get 'pages/index'

  get 'select', to: 'pages#select', as: 'select'

  post 'add', to: 'pages#add', as: 'add'

  resources :objects
end
