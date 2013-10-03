CrowdfunderRspec::Application.routes.draw do

  root :to => "welcome#index"

  resources :sessions, only: [:new, :create, :destroy]

  delete "logout" => "sessions#destroy", as: "logout"

  get "login" => "sessions#new", as: "login"

  resources :users, :except => [:index]

  resources :projects do
    resources :pledges, only: [:new, :create]
  end

  namespace :my do
    resources :projects
  end
end
