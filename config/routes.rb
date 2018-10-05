Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, only: [:index, :show]
  get 'beer/:type', to: 'beers#show'
end
