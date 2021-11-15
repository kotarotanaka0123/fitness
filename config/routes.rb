Rails.application.routes.draw do
  root 'top#index'

  get 'top', to: 'top#index'

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
    resources :messages, only: [:index, :show, :create] do
      # resources :likes, only: [:create, :destroy]
      member do
        delete :likes, to: "likes#destroy"
        post :likes, to: "likes#create"
      end
    end
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
      get :search
    end
  end

  resources :meals do
    collection do
      post :time
      get :error
      get :search
    end
  end

  get 'exercises', to: 'exercises#index'

  get 'achievement', to: 'achievement#index'

  resources :payment do
    member  do
      get 'temporary_complete', to: 'payment#temporary_complete'
      get 'pay_complete', to: 'payment#pay_complete'
      get 'cancel', to: 'payment#cancel'
    end
    collection do
      get 'complete', to: 'payment#complete'
    end
  end

end
