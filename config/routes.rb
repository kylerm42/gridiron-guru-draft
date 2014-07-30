Rails.application.routes.draw do
  root to: 'site#root'

  resources :users, only: [:new, :create], param: :username
  resource :session, only: [:new, :create, :destroy]
  resources :leagues, only: [:new, :create, :show] do
    resources :teams, only: :show, param: :draft_slot
  end
end
