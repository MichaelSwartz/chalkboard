Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  resources :athletes

  resources :competitions do
    resources :bibs, only: [:index, :create]
    resources :rounds, only: [:new, :create, :index]
  end

  resources :bibs, only: [:edit, :update, :destroy]

  resources :rounds, except: [:new] do
    resources :routes, only: [:new, :create]
  end

  resources :routes, except: [:new, :create, :index] do
    resources :attempts, only: [:new, :create, :index]
  end

  resources :attempts, only: [:edit, :update, :destroy]
end
