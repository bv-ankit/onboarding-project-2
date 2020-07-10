Rails.application.routes.draw do
  resources :users do
    resources :articles
  end
  root 'users#new'
end
