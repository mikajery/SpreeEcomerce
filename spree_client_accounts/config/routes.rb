Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  
  namespace :admin do
    resources :client_accounts, path: "clients" do
      resources :client_users, path: "users"
      resources :client_products, path: "products" do
        resources :client_product_images, path: "images"
      end
      
    end
    #resources :client_product_images
    
    # post "client_products/:product_id/images/update_positions" => "client_product_images#update_positions", 
#       as: :update_positions_admin_client_product_images
      
    
    # get "client_product/:product_id/images" => "client_product_images#index", 
#       as: :admin_client_product_images
#       
#     
#       
#     post "client_products/:product_id/image" => "client_product_images#create",
#       as: :create_admin_client_product_images
#     
#     get "client_products/:product_id/image/new" => "client_product_images#new", 
#       as: :new_admin_client_product_image
#     
#     get "client_products/:product_id/image/:id/edit" => "client_product_images#edit", 
#       as: :edit_admin_client_product_image
#     
#     get "client_products/:product_id/image/:id" => "client_product_images#show", 
#       as: :admin_client_product_image
#     
#     patch "client_products/:product_id/image/:id" => "client_product_images#update",
#       as: :update_admin_client_product_image
#     
#     put "client_products/:product_id/image/:id" => "client_product_images#update",
#       as: :update2_admin_client_product_image
#     
#     delete "client_products/:product_id/image/:id" => "client_product_images#destroy",
#     as: :delete_admin_client_product_image
    
    
    get "client_products/:id/clone" => "client_products#clone", 
      as: :clone_admin_client_product
    
    get "client_products/:id/stock" => "client_products#stock", 
      as: :stock_admin_client_product
    
    
  end
  
  #get "admin/client_accounts", to: "admin/client_accounts#index"

end
