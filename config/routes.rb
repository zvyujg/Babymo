Rails.application.routes.draw do

  # アプリケーション
  
    root 'homes#top'

  namespace :public do
    scope module: :users do
      
    end
    get 'users/welcome' => 'users#welcome', as: 'welcome'
    get 'articles/index' => 'articles#index', as: 'articles'
    get 'articles/tipcorn' => 'articles#tipcorn', as: 'tipcorn'
    resources :users, only: [:show, :edit, :update]
    resources :relations, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
      resources :articles do
        resources :comments, only: [:create, :destroy]
      end
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
