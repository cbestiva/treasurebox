TreasureboxApp::Application.routes.draw do
 
  get "/users/new_form", to: "users#new_form"
  resources :users
  resources :posts
  devise_for :users
  
  root to: "sites#index"
  get "users/show/:id" => "users#show", as: "profile"
end
