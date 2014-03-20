FreeCandy::Application.routes.draw do
  devise_for :users
  resources :users, :only => :show
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'home#index'

  get '/home/search' => 'home#search', as: :search
  get '/home/show' => 'home#show', as: :home

end
