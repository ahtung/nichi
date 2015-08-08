require 'sidekiq/web'

Rails.application.routes.draw do
  get 'invitations/index'

  get '/who', to: 'pages#who'
  get '/where', to: 'pages#where'
  root 'pages#welcome'

  # Users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Events
  resources :events, only: [:new, :create, :index, :destroy]

  # Invitations
  resources :invitations, only: [:index] do
    member do
      get 'accept'
      delete 'reject'
    end
  end

  # Sidekiq
  mount Sidekiq::Web => '/sidekiq'
end
