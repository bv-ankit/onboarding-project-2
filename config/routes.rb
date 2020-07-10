Rails.application.routes.draw do
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signup' => 'users#new'
  delete '/signout' => 'sessions#destroy'

  resources :users do
    resources :articles
  end

  root 'articles#feed'
end
