Rails.application.routes.draw do
  root to: 'users#index'
  resources :users, :search, :keywords

  resources :links do
    get 'query', on: :collection
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
