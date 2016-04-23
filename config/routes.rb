Rails.application.routes.draw do
  devise_for :users

  namespace :v1 do
    resources :clients

    resources :spaces

    resources :rooms

    resources :reservations

    resources :plans
    resources :pricings

    resources :invoices
    resources :payments


    resources :space_users
  end

end
