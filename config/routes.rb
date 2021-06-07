Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :parks, except: :destroy do
    resources :bookmarks, only: :create
    resources :reviews, only: [:new, :create, :index]
  end
  resources :bookmarks, only: [:index, :destroy]
  resources :park_categories do
    resources :votes, only: [:create, :index]
  end
end
