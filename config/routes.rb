Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  scope "/api" do
    resources :sessions, only: [:create]
    resources :users_registrations, only: [:create]

    resources :companies

    get :invoices, to: "companies#invoices"
    get :invoice_products, to: "companies#invoice_products"
    get :pis_cofins, to: "companies#pis_cofins"
  
    delete :logout, to: "sessions#logout"
    get :logged_in, to: "sessions#logged_in"
  
    root to: "static#home"
  end
end
