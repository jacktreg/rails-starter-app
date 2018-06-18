Rails.application.routes.draw do

  get 'sessions/new'

  root 'application#home'

  get '/about',      to: 'application#about'
  get '/help',       to: 'application#help'
  get '/contact',    to: 'application#contact'
  get '/signup',     to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, param: :username
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
