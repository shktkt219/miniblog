Rails.application.routes.draw do

  resources :tags, only: [:index, :new, :create]
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  #the member method arranges for the routes to respond to URLs containing the user id
  resources :users do
    member do
      get :following, :followers
    end
    resources :posts, only: [:index, :new, :show, :create, :destroy] do
      resources :comments
    end
  end

  resources :posts, only: :index

  resources :relationships, only: [:create, :destroy]
end
