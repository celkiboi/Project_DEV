Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :users
  get 'profile/:id', to: 'users#show', as: 'user_profile'
end
