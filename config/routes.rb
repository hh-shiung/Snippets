Rails.application.routes.draw do
  resources :favourites
  resources :snippets
  resources :users

  # get 'welcome' => 'landing#landingpage'
  root 'landing#landingpage'
  
end
