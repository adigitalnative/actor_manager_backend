Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auditions, only: [:index, :create, :update, :destroy]
      resources :categories, only: [:index]
      resources :projects, only: [:index]
      resources :companies, only: [:index]
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
    end
  end
end
