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
      patch 'users', to: 'users#update'
      resource :dashboard, only: [:show]

      get 'book', to: 'book_items#index'
      post 'book', to: 'book_items#create'
      patch 'book/:id', to: 'book_items#update'
      delete 'book/:id', to: 'book_items#destroy'


      post '/login', to: 'auth#create'
      post '/authorize', to: 'auth#authorize_token'
      get '/result_options', to: "report#result_options"
    end
  end
end
