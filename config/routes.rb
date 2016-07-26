Rails.application.routes.draw do
  root to: 'users#index'
  resources :users, :search, :keywords

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
