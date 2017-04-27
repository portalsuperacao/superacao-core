require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :participants, controller: 'api/v1/participants', only: [:index, :new, :create, :show, :update, :destroy] do
    resources :trinities, controller: 'api/v1/trinities', only: [:index, :new, :create, :show, :update, :destroy] do
      get  'trinities',    to: 'participants#trinities'
      post 'custom-match', to: "trinities#custom_match"
    end
  end

  resource :participant, controller: 'api/v1/participant',  only: [:show] do
    post 'activate' , to: 'api/v1/activation_code#activate'
  end

  resources :positive_messages, controller: 'api/v1/positive_messages'


  namespace :api do
    namespace :v1 do
      scope :participant do
        post 'activate' , to: 'activation_code#activate'
        scope :trinity do
          get  '',    to: 'participants#trinities'
          post 'custom-match', to: "trinities#custom_match"
        end
      end

      resources :positive_messages
    end
  end

  mount Sidekiq::Web => '/sidekiq'

  get 'swagger', to: 'api/v1/activation_code#swagger'
  root to: "home#index"
end
