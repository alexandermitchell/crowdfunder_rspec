CrowdfunderRspec::Application.routes.draw do

root :to => "projects#index"

get "/projects" => "projects#index"

get "/projects/:id" => "projects#show", as: "project"
end
