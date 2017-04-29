Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, path: 'auth', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }

  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
