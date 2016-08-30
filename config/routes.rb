Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
