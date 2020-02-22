Rails.application.routes.draw do
  get '/', to: 'games#index', as: 'root'

  resources :teams, only: [:index, :show, :update] do
    collection do
      post 'refresh'
    end
  end

  resources :parlay, only: [:index, :create]

  resources :games, only: [:show] do
    member do
      post :action
    end

    collection do
      post :filter
    end
  end
end
