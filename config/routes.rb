Rails.application.routes.draw do
  root 'main/spa#index'

  devise_for :users,
    controllers: {
      sessions: 'api/v1/users/sessions',
      registrations: 'api/v1/users/registrations'
    }

  namespace :api do
    namespace :v1 do
      resources :permissions, only: [:index, :create, :destroy] do
        collection do
          get :available_roles
        end
      end
      resources :doc_tags, only: [:create, :update, :destroy, :index]
      resources :activity_areas, only: [:create, :update, :destroy, :index]
      resources :users, only: [] do
        collection do
          get :search
        end
      end
      resources :documents
      resources :document_files, only: [:destroy]
      resources :change_orders, only: [:destroy]
    end
  end

  get 'api/v1/member-data', to: 'api/v1/members#show'

  %w(main directory manage profile).each do |key|
    namespace(key) { root to: 'spa#index' }
  end
end
