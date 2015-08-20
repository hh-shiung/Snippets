Rails.application.routes.draw do
  # devise_for :users
  resources :favorites
  resources :snippets
  resources :users

  # get 'welcome' => 'landing#landingpage'
  root 'landing#landingpage'

  # Facebook login
  get 'auth/:provider/callback', to: 'users#fbcreate'
  match "/auth/failure" => redirect("/login"), via: [:get, :post]
  # Facebook login

  get '/index' => 'users#showIndex'
  post '/index' => 'users#showIndex'

  get '/login' => 'users#showLogin'
  get '/lock' => 'users#showLock'
  get '/logout' => 'users#showLogout'
  get '/register' => 'users#new'
  get '/personal' => 'users#showPersonal'

  get '/fav/:id' => 'snippets#save_favorite', as: :fav

  get '/performance' => 'users#showPerformance'

  get '/confirmation/:token' , to: 'users#verifyToken'

  get '/test' => 'users#sendEmail'

  post '/getinput' => 'users#getinput'
  post '/forgotpw' => 'users#forgotPW'
  get '/forgotpw/:token' => 'users#verifyToken'

end
