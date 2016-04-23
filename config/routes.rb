Rails.application.routes.draw do
  devise_for :users

  namespace :v1 do
    resources :clients

    resources :spaces

    resources :space_users
  end

end
