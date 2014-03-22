TreasureboxApp::Application.routes.draw do
  devise_for :users
  
  root to: "sites#index"
  get "users/show/:id" => "users#show", as: "profile"
  resources :post_items
end
