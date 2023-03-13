Rails.application.routes.draw do

  # アプリケーション
  scope module: :public do
    root 'homes#top'
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
