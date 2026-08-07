Rails.application.routes.draw do
  devise_for :customers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products, only: [ :show ]
  get "about", to: "pages#about", as: :about
  get "contact", to: "pages#contact", as: :contact
  get "shell_jackets", to: "pages#shell_jackets", as: :shell_jackets
  get "insulated_jackets", to: "pages#insulated_jackets", as: :insulated_jackets
  get "lifestyle_jackets", to: "pages#lifestyle", as: :lifestyle
  get "cart", to: "carts#show", as: :cart
  get "checkout",
      to: "checkouts#new",
      as: :checkout
  post "cart/add/:product_id", to: "carts#add", as: :add_to_cart
  patch "cart/update/:product_id",
      to: "carts#update",
      as: :update_cart_item
  post "checkout",
     to: "checkouts#create",
     as: :place_order
  get "orders/:id/confirmation",
    to: "orders#show",
    as: :order_confirmation

  delete "cart/remove/:product_id",
       to: "carts#remove",
       as: :remove_from_cart

  root "home#index"
end
