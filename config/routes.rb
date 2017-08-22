require "sidekiq/web"
Rails.application.routes.draw do
  
  resources :notifications, only: [:index,:update]
  resources :posts
  resources :usuarios, as: :users, only: [:show,:update]
  resources :friendships, only: [:create,:update,:index]
  devise_for :users, controllers:{
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  
  post "/custom_sign_up", to: "users/omniauth_callbacks#custom_sign_up"
  
  authenticated :user do
    root 'main#home'
  end
  
  unauthenticated :user do
    root 'main#unregistered'
  end
  
  mount ActionCable.server => '/cable'
  ActionCable.server.config.disable_request_forgery_protection = true
  mount Sidekiq::Web => '/sidekiq'
end
