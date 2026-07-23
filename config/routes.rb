Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products, only: [:show]
  get "about", to: "pages#about", as: :about
  get "contact", to: "pages#contact", as: :contact
  get "shell_jackets", to: "pages#shell_jackets", as: :shell_jackets
  get "insulated_jackets", to: "pages#insulated_jackets", as: :insulated_jackets
  get "lifestyle_jackets", to: "pages#lifestyle", as: :lifestyle

  root "home#index"
end