require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  resources :participants,  only: [:index, :new, :create, :show, :update, :destroy] do
    resources :trinities, controller: 'api/v1/trinities', only: [:index, :new, :create, :show, :update, :destroy] do
      get  'trinities',    to: 'participants#trinities'
      post 'custom-match', to: "trinities#custom_match"
    end
  end

  resource :participant, controller: 'api/v1/participant',  only: [:show] do
    post 'activate' , to: 'api/v1/activation_code#activate'
  end

  resources :positive_messages


  namespace :api do
    namespace :v1 do
      scope :participant do
        get '', to: 'participants#show'
        post '', to: 'participants#create'
        post 'activate' , to: 'activation_code#activate'
        scope :trinity do
          get  '',    to: 'participants#trinities'
          post 'custom-match', to: "trinities#custom_match"
          get  'match', to: "trinities#match"
        end
      end

      resources :treatment_types, only: [:index]
      resources :cancer_types, only: [:index]
      resources :positive_messages
    end
  end

  mount Sidekiq::Web => '/sidekiq'

  get 'swagger', to: 'api/v1/activation_code#swagger'
  root to: "home#index"
end
