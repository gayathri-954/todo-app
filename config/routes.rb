Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # User authentication routes (if using Devise Token Auth)
  mount_devise_token_auth_for 'User', at: 'auth'

  # Todo routes
  resources :todos

  # You can optionally set a root path (optional)
  root "todos#index"
end
