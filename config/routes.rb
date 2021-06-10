Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  scope "/api" do
    resources :sessions, only: [:create]
    resources :users_registrations, only: [:create]

    resources :companies

    get :invoices, to: "companies#invoices"
  
    delete :logout, to: "sessions#logout"
    get :logged_in, to: "sessions#logged_in"
  
    root to: "static#home"
  end
end
