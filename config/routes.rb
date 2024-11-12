Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :users
  get 'profile/:id', to: 'users#show', as: 'user_profile'
  get 'profile/:id/connections', to: 'users#connections', as: 'user_connections'

  resources :users, only: [:show] do
    member do
      post 'follow'
      delete 'unfollow'
    end
  end  
end
