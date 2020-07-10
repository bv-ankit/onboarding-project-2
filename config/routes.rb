Rails.application.routes.draw do
  get '/signin' => 'sessions#new'
  get '/signup' => 'users#new'
  # get '/signout' => 'users#signout'
  post '/signin' => 'sessions#create'
  delete '/signout' => 'sessions#destroy'

  resources :users do
    resources :articles
  end

  root 'articles#feed'
  
  post '/sessions' => 'sessions#create'

end
