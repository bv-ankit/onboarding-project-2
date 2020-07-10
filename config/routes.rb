Rails.application.routes.draw do
  resources :users do
    resources :articles
  end
  root 'articles#feed'
  post '/sessions' => 'sessions#create'
  get '/signin' => 'users#signin'
  get '/signup' => 'users#signup'
  get '/signout' => 'users#signout'
end
