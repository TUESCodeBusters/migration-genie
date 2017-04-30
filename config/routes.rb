Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :sightings
    resources :species
    resources :locations

    root to: "users#index"
  end

  resources :sightings
  scope '/api' do
    get '/sightings', to: 'sightings#get'
    get '/locations', to: 'locations#get'
    get '/species', to: 'species#get'
  end

  resources :species
  resources :locations
  get 'home/index'

  devise_for :users, path: 'auth', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }

  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
