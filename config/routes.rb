Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :parks, except: :destroy
  resources :park_categories do
    resources :votes, only: [:create, :index]
  end
end
