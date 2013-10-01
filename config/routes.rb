CrowdfunderRspec::Application.routes.draw do

root :to => "welcome#index"

get "/projects" => "projects#index"

get "/projects/:id" => "projects#show", as: "project"
end
