# frozen_string_literal: true

Rails.application.routes.draw do
  root 'collaborators#index'

  resources :collaborators do
    collection do
      get :report
    end
  end
  resources :users

  post '/users' => 'users#create'
  get '/collaborator' => 'collaborators#index'
  get '/collaborators/calculate_inss_discount/:salary' => 'collaborators#calculate_inss_discount'
  get '/login' => 'sessions#new'
  delete '/logout' => 'sessions#destroy'
  post '/sessions' => 'sessions#create'
end
