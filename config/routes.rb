Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'

  resource :users
  #Get and post request with login routes
  get 'login',   to: 'sessions#new'
  post 'login',   to: 'sessions#create'
  #Get delete request with logout route
  delete 'logout',  to: 'sessions#destroy'
end
