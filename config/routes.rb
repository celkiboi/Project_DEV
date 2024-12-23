Rails.application.routes.draw do
  resources :posts
  root 'static_pages#home'

  devise_for :users, path: 'korisnici', path_names: {
  sign_in: 'prijava',
  sign_out: 'odjava',
  sign_up: 'registracija',
  password: 'lozinka',
  confirmation: 'potvrda',
  unlock: 'otkljucaj',
  edit: 'uredi'
}

  get 'profil/:id', to: 'users#show', as: 'user_profile'
  get 'profil/:id/veze', to: 'users#connections', as: 'user_connections'
  get 'profil/:id/objave', to: 'posts#user_posts', as: 'user_posts'
  get 'objave/novo', to: 'posts#new', as: 'post_new'
  post 'objave/kreiraj', to: 'posts#create', as: 'post_create'
  get 'objave/:id', to: 'posts#show', as: 'show_post'

  resources :users, only: [:show] do
    member do
      post 'follow', to: 'users#follow', as: :follow
      delete 'unfollow', to: 'users#unfollow', as: :unfollow
    end
  end

  resources :posts do
    member do
      put :publish
    end
  end
  
end
