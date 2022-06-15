Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'

  # Set Project Root Page #
  root 'static_pages#home'

  # Set Project Directories #
  get '/about',      to: 'static_pages#about'
  get '/contact',    to: 'static_pages#contact'
  get '/donate',     to: 'static_pages#donate'
  get '/admin',      to: 'static_pages#admin'
  get '/howto',      to: 'static_pages#howto'
  get '/coinbase',   to: 'static_pages#coinbase'
  get '/nft',        to: 'static_pages#nft'

  # Set Users Directories #
  get    '/signup',     to: 'users#new'
  get    '/login',      to: 'sessions#new'
  post   '/login',      to: 'sessions#create'
  delete '/logout',     to: 'sessions#destroy'

  # Set Chatroom Directories #

  # Set Project Deck Feed Directory #
  get '/microposts', to: 'static_pages#home'

  # Set Project Resources #
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts,          only: [:create, :destroy] do
    resources :comments
  end
  resources :comments do
    resources :comments
  end
  resources :relationships,       only: [:create, :destroy]

end
