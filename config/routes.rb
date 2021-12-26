Rails.application.routes.draw do

  devise_for :users, 
    path: '',
    path_names: {
      sign_up: '',
      sign_in: 'login',
      sign_out: 'logout',
      registration: "signup",
    },
    :controllers => {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions',
      :passwords => 'users/passwords',
      :confirmations => 'users/confirmations'
  } 

  devise_scope :user do
    get 'username', to: 'users/registrations#username', as: :username_registration
    post 'username', to: 'users/registrations#addingUsername'
  end
  
  # ホーム画面
  root to: 'fitness#index'

  resources :users do
    # フォロー・フォロワーに関して
    resource :relationships, only: [:create, :destroy]
    get 'followings', to: 'relationships#followings', as: 'followings'
    get 'followers', to: 'relationships#followers'
    get 'config', to: 'config#index'
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
      post :search_result
      get :show_info
    end
  end

  resources :meals do
    collection do
      post :time
      get :error
      get :search
      post :search_result
      get :show_info
      get :update_nutrition_score
    end
  end

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
