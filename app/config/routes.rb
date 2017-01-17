Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :participants, only: [:index, :create, :show, :update, :destroy]

  scope '/participant' do
    get 'trinities' => 'participants#trinities'
  end

  scope '/trinities' do
      get '/' => "trinities#index"
      post '/custom-match' => "trinities#custom_match"
  end

  get 'firebase_token' => 'tokens#firebase_token'
  post 'activate' => 'activation_code#activate'

  get "home/index"
  get "home/minor"
  root to: "home#index"
end
