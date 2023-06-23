Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts do
          resources :comments
          resources :likes, only: [:create]
        end
      end
    end
  end
end
