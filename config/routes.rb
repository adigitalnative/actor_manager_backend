Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auditions, only: [:index, :create, :update, :destroy]
      resources :categories, only: [:index]
      resources :projects, only: [:index]
    end
  end
end
