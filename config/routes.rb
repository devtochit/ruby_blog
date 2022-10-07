Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show create] do
      resources :comments, only: [:create]
      resources :likes, only: [:create]
    end
  end

  # Defines the root path route ("/")
  root 'users#index'
end
