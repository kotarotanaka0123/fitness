Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users do
      # フォロー・フォロワーに関して
      resource :relationships, only: [:create, :destroy]
      get 'followings', to: 'relationships#followings', as: 'followings'
      get 'followers', to: 'relationships#followers'
    end
  end

  # メッセージ機能
  resources :groups, only: [:index, :new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
  end
  
  # ホーム画面
  get 'fitness', to: 'fitness#index'
  root to: 'fitness#index'

  resources :goals do
    collection do
      get 'configBody', to: 'goals#body'
      post :configBody
      get :configCalorie
    end 
  end

  resources :ingredients do
    collection do
      post :addToMeal
      get :select
    end
  end

  resources :meals do
    collection do
      post :time
      get :error
    end
  end

  get 'exercises', to: 'exercises#index'

end
