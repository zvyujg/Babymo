  Rails.application.routes.draw do
  
  devise_for :admins, controllers: {
   sessions: 'admin/admins/sessions'
  }
  
  devise_for :users, :controllers => {
      registrations: "public/users/registrations",
      sessions: "public/users/sessions"
  }
  
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/users/sessions#guest_sign_in'
  end
  
  get 'homes/top'
  root to: "homes#top"
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'articles/index'
  get 'articles/:id/edit' => 'articles#edit', as: 'edit_article'
  
 
  
  scope module: :public do
    resources :articles do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :questions, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
       resources :question_comments, only: [:create, :destroy]
    end
    resources :follows, only: [:index, :followers, :followings]
    resources :users, only: [:index, :show, :edit, :update, :unsubscribe] do
    resources :relations, only: [:create, :destroy]
      get 'followings' => 'relations#followings', as: 'followings'
      get 'followers' => 'relations#followers', as: 'followers'
      member do
        get :favorites
      end  
     
    end  
    
      # 退会確認画面
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
     # 論理削除用のルーティング
    patch '/users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
    
  end
  
    # 管理者
  namespace :admin do
    scope module: :admins do
      devise_for :admins
    end
    root 'users#top'
    resources :users, only: [:index, :show, :update, :destroy]
    resources :articles, only: [:index, :show, :update, :destroy]
    resources :comments, only: [:index, :update, :destroy]
    resources :tags, only: [:index, :update, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
