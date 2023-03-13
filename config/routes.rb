Rails.application.routes.draw do
  devise_for :admins, controllers: {
  sessions: 'admin/sessions'
}
  
  
  devise_for :users, :controllers => {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
  get 'homes/top'
  root to: "home#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
