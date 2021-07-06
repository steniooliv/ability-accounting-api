Rails.application.routes.draw do
  
  scope "/api" do
    resources :sessions, only: [:create]
    
    resources :companies

    get :invoices, to: "companies#invoices"
    get :invoice_products, to: "companies#invoice_products"
    get :pis_cofins, to: "companies#pis_cofins"
    get :cfop_products, to: "companies#cfop_products"
  
    delete :logout, to: "sessions#logout"
    get :logged_in, to: "sessions#logged_in"
  end

  namespace :api do
    
    namespace :v1 do
      
      resources :users
      resources :accountings
      resources :companies
      resources :customers
      
      resources :invoices do
        resources :products
      end

      root to: "static#home"
    end

  end

end