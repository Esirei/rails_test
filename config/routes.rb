Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # made home the root directory
  root 'pages#home'

  # unnecessary since it's now the root
  get 'pages/home'

  # about path automatically picks controller action
  get 'pages/about'

  # about path, linked with controller action, doesn't show controller name :)
  get 'about', to: 'pages#about'

  # creates routes for edit, delete, post, get, put and patch article
  resources :articles

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources(:categories, except: [:destroy])
end
