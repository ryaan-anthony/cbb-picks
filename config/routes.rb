Rails.application.routes.draw do
  get '/', to: 'games#index', as: 'root'

  resources :games, only: [:show] do
    member do
      post :action
    end

    collection do
      post :filter
    end
  end
end
