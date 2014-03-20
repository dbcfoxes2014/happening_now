FreeCandy::Application.routes.draw do
  devise_for :users
  resources :users, :only => :show
  get 'editor/home', :to => 'editor#home'

  root to: 'home#index'
end
