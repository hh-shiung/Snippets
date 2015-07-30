Rails.application.routes.draw do
  resources :favorites
  resources :snippets
  resources :users

  # get 'welcome' => 'landing#landingpage'
  root 'landing#landingpage'

  get '/index' => 'display#showIndex'
  get '/users/new' => 'users#new'

end
