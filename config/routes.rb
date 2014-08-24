Rails.application.routes.draw do
  root to: 'site#root'

  resources :users, only: [:new, :create], param: :username
  resource :launchpad, only: :show
  resource :session, only: [:new, :create, :destroy]
  resources :leagues, only: [:new, :create, :edit, :update] do
    collection do
      get :invite
      post :join
    end
    member do
      get :draft
    end
    resources :teams, only: [:edit, :show], param: :draft_slot
  end

  resources :teams, only: [:update] do
    member do
      patch :remove_owner
    end
  end

  resources :players, only: [:index, :show]

  resources :draft_picks, only: [:index, :update]
end
