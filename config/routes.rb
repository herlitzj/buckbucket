Rails.application.routes.draw do
  root to: 'pages#index'
  resources :sessions, only: :index
  get "/auth/:provider/callback", to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
