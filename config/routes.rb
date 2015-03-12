Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#add'
  get '/auth/failure', to: redirect('/')

  get 'signout/:provider', to: 'sessions#destroy', as: 'signout'
  resources :posts, only: [:new, :create]
  root to: 'posts#new'
end