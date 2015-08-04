Rails.application.routes.draw do
  resources :favorites
  resources :snippets
  resources :users

  # get 'welcome' => 'landing#landingpage'
  root 'landing#landingpage'

  post '/index' => 'users#showIndex'
  get '/login' => 'users#showLogin'
  get '/lock' => 'users#showLock'
  get '/register' => 'users#new'
  get '/confirmation/:token' , to: 'users#verifyToken'
end
