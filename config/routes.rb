Rails.application.routes.draw do
  get '/:username', to: "users#show", as: "user"
end
