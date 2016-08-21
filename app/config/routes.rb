Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :participants, only: [:index, :create, :show, :update, :destroy] do
    get 'trinities' => 'participants#trinities'
  end

  post 'activate' => 'activation_code#activate'
end
