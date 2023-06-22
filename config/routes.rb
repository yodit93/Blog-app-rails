Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:show] do
    resources :posts do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end 
end
