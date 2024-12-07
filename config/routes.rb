Rails.application.routes.draw do

root to: "public/homes#about" # アプリ起動時に about ページを表示
  get "/about", to: "public/homes#about", as: "about"

  devise_scope :user do
    get "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
    resources :tasks, only: [:index, :new, :create, :show, :edit, :update]
  end

  scope module: :public do
    resources :posts, only: [:new, :create, :edit, :update, :destroy, :index, :show]
    resources :tasks, only: [:index, :show]
    get "users/information/:id" => "users#show", as: 'user'
    resources :users, only: [:edit, :update, :destroy]
    
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
