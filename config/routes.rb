TreasureboxApp::Application.routes.draw do
  devise_for :users
  # devise_scope :user do 
  #   root to: "devise/sessions#new"
  # end

  root to: "sites#index"
end
