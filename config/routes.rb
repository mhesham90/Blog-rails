Rails.application.routes.draw do
  root to: "users#index"
  devise_for :users
  resources :users
  resources :posts do
    resources :comments
  end
  get 'users/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end