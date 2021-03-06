Rails.application.routes.draw do
  get '/', to: 'games#index', as: 'root'

  resources :teams, only: [:index, :update] do
    member do
      get :last_game
    end
    collection do
      post :refresh
    end
  end

  resources :parlay, only: [:index, :create]

  resources :games, only: [:show] do
    member do
      post :action
    end

    collection do
      post :filter
      post :refresh
    end
  end
end
