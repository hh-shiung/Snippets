Rails.application.routes.draw do

  resources :snippets
  resources :users

  root 'users#index'
end
