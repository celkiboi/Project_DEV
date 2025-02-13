Rails.application.routes.draw do
  root "static_pages#home"

  devise_for :users, path: "korisnici", path_names: {
  sign_in: "prijava",
  sign_out: "odjava",
  sign_up: "registracija",
  password: "lozinka",
  confirmation: "potvrda",
  unlock: "otkljucaj",
  edit: "uredi"
}

  resources :users, path: "korisnici", only: [ :show ] do
    member do
      get "veze", to: "users#connections", as: :connections
      get "objave", to: "posts#user_posts", as: :posts
      post "follow", to: "users#follow", as: :follow
      delete "unfollow", to: "users#unfollow", as: :unfollow
    end
  end

  resources :posts, path: "objave", only: [ :show, :new, :create ] do
    member do
      put :publish
    end
    resources :comments, path: "komentari", only: [ :create, :destroy ]
  end

  resources :notifications, path: "obavijesti", only: [ :index, :show ]
end
