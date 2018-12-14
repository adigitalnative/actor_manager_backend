Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auditions, only: [:index, :create, :update, :destroy] do
        patch '/report', to: 'report#update'
      end

      resources :categories, only: [:index]
      resources :projects, only: [:index]
      resources :companies, only: [:index]
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      post '/authorize', to: 'auth#authorize_token'
    end
  end
end
