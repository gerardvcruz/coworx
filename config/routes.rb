Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

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
