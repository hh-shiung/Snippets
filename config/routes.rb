Rails.application.routes.draw do
  resources :favorites
  resources :snippets
  resources :users

  # get 'welcome' => 'landing#landingpage'
  root 'landing#landingpage'

  get '/index' => 'users#showIndex'
  post '/index' => 'users#showIndex'
  get '/login' => 'users#showLogin'
  get '/lock' => 'users#showLock'
  get '/register' => 'users#new'
  get '/personal' => 'users#showPersonal'
  get '/fav' => 'users#showFav'
  get '/performance' => 'users#showPerformance'
  get '/confirmation/:token' , to: 'users#verifyToken'
end
