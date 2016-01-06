Rails.application.routes.draw do

  root to: "users#index"
  get '/login', to: "sessions#new", as: "login"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy", as: "logout"
  get '/timeline', to: "users#timeline"
  get '/mentions', to: "users#mentions"


  resources :statuses, only: [:new, :create]
  resources :users, only: [:new, :create] do
    member do
      post 'follow'
      post 'unfollow'
    end
  end
  get '/:username', to: "users#show", as: "user"
end
