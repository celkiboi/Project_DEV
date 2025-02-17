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

  devise_for :admins, controllers: { sessions: "admins/sessions" }, skip: [ :registrations ], path: "admin", path_names: {
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

  namespace :admin, path: "admin" do
    get "objave", to: "posts#index", as: :posts_index
    get "objave/:id", to: "posts#show", as: :post
    get "korisnici", to: "users#index", as: :users_index
    get "korisnici/:id", to: "users#show", as: :user
    get "korisnici/:id/objave", to: "users#posts", as: :user_posts
    get "administratori", to: "admins#index", as: :admins_index
    root to: "dashboard#index"

    resources :admins, path: "administratori", only: [ :index ]
    resources :users, path: "korisnici", only: [ :index, :show ] do
      member do
        get "objave", to: "users#posts"
      end
    end
    resources :posts, path: "objave", only: [ :index, :show ]
  end
end
