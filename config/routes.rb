Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'user_token', to: 'user_token#create'
      resources :users, only: %i[create update] do
        get 'current', on: :collection
      end
    end
  end
end