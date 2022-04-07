Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    post 'csv' => 'csv#index'
    post 'pdf' => 'pdf#index'
    resources :risks, except: [:edit]
    resources :policies, except: [:edit]

    resources :exams, except: [:edit] do
      post 'completed', on: :member
      resources :share_exams, only: [:index, :create, :destroy]
      resources :exam_requests, except: [:edit]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  root "dashboard#index"
end
