Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  
  namespace :admin do
    resources :client_accounts
  end
  
  #get "admin/client_accounts", to: "admin/client_accounts#index"

end