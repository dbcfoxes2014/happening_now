  FreeCandy::Application.routes.draw do
  devise_for :users
  resources :users, :only => :show
  # resources :dan
  # match 'video', to: 'home#video', via: :get, format: :json
  # match 'save_video_url', to: 'home#save_video_url', via: :post
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root to: 'home#index'

  match 'search', to: 'home#search', via: :get
  match 'popular', to: 'home#popular', via: :get
  match 'display', to: 'home#display', via: :get
  get '/home/show' => 'home#show', as: :home


end
