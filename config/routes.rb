Rails.application.routes.draw do

  root 'application#home'

  get '/about', to: 'application#about'
  get '/help', to: 'application#help'
  get  '/contact', to: 'application#contact'
  get  '/signup',  to: 'users#new'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
