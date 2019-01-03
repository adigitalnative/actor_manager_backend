Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auditions, only: [:index, :create, :update, :destroy] do
        patch '/report', to: 'report#update'
      end

      resources :categories, only: [:index]
      resources :projects, only: [:index, :update]
      resources :companies, only: [:index, :update]
      resources :opportunities, only: [:index] do
        patch '/archive', to: 'opportunities#toggle_archived'
        post '/audition', to: 'auditions#create_from_opportunity'
      end

      resources :users, only: [:create]
      patch 'users', to: 'users#update'

      resource :dashboard, only: [:show] do
        patch 'auditions/:audition_id/report', to: 'report#dashboard_update'
        patch 'projects/:id', to: 'projects#dashboard_update'
      end

      get 'book', to: 'book_items#index'
      post 'book', to: 'book_items#create'
      patch 'book/:id', to: 'book_items#update'
      delete 'book/:id', to: 'book_items#destroy'


      post '/login', to: 'auth#create'
      post '/authorize', to: 'auth#authorize_token'
      get '/result_options', to: "report#result_options"

      post '/subscribe', to: "mailing_list_signups#create"
    end
  end
end
