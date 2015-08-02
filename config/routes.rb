Rails.application.routes.draw do
  resources :favorites
  resources :snippets
  resources :users

  # get 'welcome' => 'landing#landingpage'
  root 'landing#landingpage'

  get '/index' => 'display#showIndex'
  get '/users/new' => 'users#new'
  get '/login' => 'display#showLogin'
  get '/lock' => 'display#showLock'
  get '/register' => 'users#new'

end
