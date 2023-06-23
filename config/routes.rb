Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show] do
        resources :posts do
          resources :comments, only: [:new, :create, :destroy]
          resources :likes, only: [:create]
        end
      end
    end
  end
end
