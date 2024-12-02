Rails.application.routes.draw do
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

  resources :users, only: [:show] do
    member do
      post 'prati'
      delete 'odprati'
    end
  end  
end
