Rails.application.routes.draw do
  get 'events/index'

  get 'events/destroy'

  get '/where', to: 'pages#where'
  root 'pages#welcome'

  # Users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :events, only: [:new, :create, :index, :destroy]
end
