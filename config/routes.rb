Rails.application.routes.draw do
  root 'main/spa#index'

  namespace :api do
    namespace :v1 do
      get 'sessions/create'
      get 'sessions/destroy'
      resources :users
    end
  end
end
