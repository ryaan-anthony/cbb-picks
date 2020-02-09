Rails.application.routes.draw do
  get '/', to: 'games#index', as: 'root'
  post 'games/import'
  resources :teams, only: [:show]
  resources :games, only: [:show]
end
