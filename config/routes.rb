  FreeCandy::Application.routes.draw do
  devise_for :users
  resources :users, :only => :show
  get 'editor/video', :to => 'editor#video'
  get 'editor/photo', :to => 'editor#photo'
  get 'editor/renderIO', :to => 'editor#renderStatus'
  post 'editor/renderIO', :to => 'editor#renderCommand'
  resources :dan
  match 'video', to: 'home#video', via: :get

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

  match 'next', to: 'home#next', via: :get
  match 'back', to: 'home#back', via: :get


  post "/save_media_to_session" => "home#save_media", :as => :save_media_to_session






  post "/remove_media_from_session" => "home#remove_media", :as => :remove_media_from_session

  get "/debug_grab_test_urls" => "home#debug_grab_test_urls", :as => :debug_grab_test_urls

end
