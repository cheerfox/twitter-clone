Rails.application.routes.draw do
  resources :statuses, only: [:new, :create]
  resources :users, only: [:new, :create]
  get '/:username', to: "users#show", as: "user"
end
