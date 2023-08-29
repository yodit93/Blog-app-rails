Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
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
