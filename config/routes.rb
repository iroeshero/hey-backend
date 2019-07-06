Rails.application.routes.draw do

  devise_for :users

  get 'home/index'
  root to: "home#index"

  resources :members, param: :_username
  post '/auth/login', to: 'authentication#login'

  get '/*a', to: 'application#not_found'


end
