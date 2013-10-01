CrowdfunderRspec::Application.routes.draw do

root :to => "welcome#index"

resources :users, :except => [:index]

get "/projects" => "projects#index"

get "/projects/:id" => "projects#show", as: "project"
end
