Rails.application.routes.draw do
  root to: 'pages#index'
  resources :sessions, only: :index
  resources :markers
  resources :users
  resources :initial_markers, only: [:new, :create]
  post "/markers/:id/make_payment", to: 'markers#make_payment'
  post "/markers/:id/claim_marker", to: 'markers#claim_marker'
  get "/auth/:provider/callback", to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
