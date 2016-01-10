Rails.application.routes.draw do
  root to: 'pages#index'
  resources :sessions, only: :index
  resources :markers
  resources :users
  get "/auth/:provider/callback", to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
