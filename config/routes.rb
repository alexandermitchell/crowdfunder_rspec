CrowdfunderRspec::Application.routes.draw do

root :to => "welcome#index"

resources :sessions, only: [:new, :create, :destroy]

delete "logout" => "sessions#destroy", as: "logout"

get "login" => "sessions#new", as: "login"

resources :users, :except => [:index]

get "/projects" => "projects#index"

get "/projects/:id" => "projects#show", as: "project"
end
