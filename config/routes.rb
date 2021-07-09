Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end
  
  get 'fitness', to: 'fitness#index'
  root to: 'fitness#index'

  resources :goals do
    collection do
      get 'configBody', to: 'goals#body'
      post :configBody
      get :configCalorie
    end 
  end

  resources :foods do
    collection do
      get :addToMeal
    end
  end

  get 'exercises', to: 'exercises#index'
end
