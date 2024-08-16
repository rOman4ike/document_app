Rails.application.routes.draw do
  root 'main/spa#index'

  devise_for :users,
    controllers: {
      sessions: 'api/v1/users/sessions',
      registrations: 'api/v1users/registrations'
    }

  get 'api/v1/member-data', to: 'api/v1/members#show'

  %w(main directory manage).each do |key|
    namespace(key) { root to: 'spa#index' }
  end
end
