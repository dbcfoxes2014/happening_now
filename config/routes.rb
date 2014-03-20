FreeCandy::Application.routes.draw do
  devise_for :users
  resources :users, :only => :show

  root to: 'home#index'


  get '/home/search' => 'home#search', as: :search
  get '/home/show' => 'home#show', as: :home


end
