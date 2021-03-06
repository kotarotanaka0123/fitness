Rails.application.routes.draw do

  devise_for :users, 
    path: '',
    path_names: {
      sign_up: '',
      sign_in: 'signin',
      sign_out: 'logout',
      registration: "signup",
    },
    :controllers => {
      :sessions => 'users/sessions',
      :registrations => 'users/registrations',
      :passwords => 'users/passwords',
      :confirmations => 'users/confirmations'
  } 

  devise_scope :user do
    get 'username', to: 'users/registrations#username', as: :username_registration
    patch 'add_username', to: 'users/registrations#addingUsername', as: :add_username
    put 'change_username', to: 'users/registrations#changeUsername', as: :change_username
    get 'body_details', to: 'users/registrations#body_details'
    patch 'add_body_details', to: 'users/registrations#add_body_details'
    get 'confirm_email', to: 'users/registrations#confirm_email'
  end
  
  # ホーム画面
  root to: 'fitness#index'

  resources :users do
    # フォロー・フォロワーに関して
    resources :relationships, only: [:index, :create, :destroy]
    get 'relationships/search', to: 'relationships#search'
    get 'config', to: 'config#index'
  end

  resources :goals do
    collection do
      get :configCalorie
    end 
  end

  resources :ingredients do
    collection do
      get :addToMeal
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

  # コミュニティ
  get 'community', to: 'community#index'
  namespace :community do
    resources :groups do
      resources :messages, only: [:index, :new, :show, :create] do
        # resources :likes, only: [:create, :destroy]
        member do
          delete :likes, to: "likes#destroy"
          post :likes, to: "likes#create"
        end
      end
      member do
        get :join, to: 'groups#join'
        get :join_invited_group, to: 'groups#join_invited_group'
      end
      collection do
        get :search, to: 'groups#search'
        get :userlist, to: 'groups#userlist'
        get :invite_users, to: 'groups#inviteUsers'
        post :invite_users, to: 'groups#create_inviteUsers'
      end
    end
  end

  # メール確認用
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
