TreasureboxApp::Application.routes.draw do
  resources :posts
  devise_for :users
  
  root to: "sites#index"
  get "users/show/:id" => "users#show", as: "profile"
end
