TreasureboxApp::Application.routes.draw do
  resources :posts
  get "/users/new_form", to: "users#new_form"
  get "/users/sign_up_form", to: "users#sign_up_form"
  devise_for :users
  resources :users
  
  root to: "sites#index"
  get "users/show/:id" => "users#show", as: "profile"
end
