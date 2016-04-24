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

    get 'users/active' => 'users#active'
    
    resources :users, except: :destroy

    resources :space_users

    post 'sessions/checkin' => 'sessions#checkin'
    post 'sessions/checkout' => 'sessions#checkout'
  end
end
