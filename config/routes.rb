Rails.application.routes.draw do
  root to: 'site#root'

  resources :users, only: [:new, :create], param: :username
  resources :sessions, only: [:new, :create, :destroy]
  resources :leagues, only: [:new, :create, :show]
end
