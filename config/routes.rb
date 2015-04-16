Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  resources :athletes

  resources :competitions do
    resources :rounds, only: [:new, :create, :index]
  end

  resources :rounds, except: [:new] do
    resources :routes, only: [:new, :create]
  end

  resources :routes, except: [:new, :create, :index] do
    resources :attempts, only: [:new, :create, :index]
  end

  resources :attempts, except: [:new, :create, :index]
end
