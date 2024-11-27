# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'pages#index'

  get 'pages/index'

  get 'download_as_json', to: 'pages#download_json'

  get 'download_as_csv', to: 'pages#download_csv'

  get 'print_to_console', to: 'pages#print_console'

  resources :objects
end
