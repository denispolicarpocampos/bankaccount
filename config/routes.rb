require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      post 'user_token', to: 'user_token#create'
      resources :users, only: %i[create update] do
        get 'current', on: :collection
      end
      post 'transfer', to: 'historics#create'
      get 'accounts/:account_id', to: 'accounts#show'
    end
  end
end