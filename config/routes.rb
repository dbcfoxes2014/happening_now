FreeCandy::Application.routes.draw do
  devise_for :users
  resources :users, :only => :show
  resources :dan
  match 'video', to: 'home#video', via: :get

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root to: 'home#index'

  match 'search', to: 'home#search', via: :get
  match 'popular', to: 'home#popular', via: :get
  # get '/home/search' => 'home#search', as: :search
  get '/home/show' => 'home#show', as: :home


end
