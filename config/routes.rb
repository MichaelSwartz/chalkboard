Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  resources :athletes

  resources :competitions do
    resources :bibs, only: [:index, :create]
    resources :rounds, only: [:new, :create]
  end

  resources :bibs, only: [:edit, :update, :destroy]

  resources :rounds, only: [:show, :edit, :update, :destroy] do
    resources :routes, only: [:new, :create]
  end

  resources :routes, only: [:show, :edit, :update, :destroy] do
    resources :attempts, only: [:new, :create, :index]
  end

  resources :attempts, only: [:edit, :update, :destroy]
end
