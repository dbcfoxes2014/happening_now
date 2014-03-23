  FreeCandy::Application.routes.draw do
  devise_for :users
  resources :users, :only => :show
  resources :videos, :only => :show
  resources :pictures, :only => :show

  root to: 'home#index'
  get 'editor/video', :to => 'editor#video'
  get 'editor/photo', :to => 'editor#photo'
  get 'editor/renderIO', :to => 'editor#renderStatus'
  post 'editor/renderIO', :to => 'editor#renderCommand'

  match 'search', to: 'home#search', via: :get
  match 'popular', to: 'home#popular', via: :get
  match 'display', to: 'home#display', via: :get

 

  match 'recently_created_media', to: 'home#recent_media', via: :get
  match 'view_selected_media', to: 'home#view_selected_media', via: :get


  get '/home/show' => 'home#show', as: :home

  match 'next', to: 'home#next', via: :get
  match 'back', to: 'home#back', via: :get
  post "/save_media_to_session" => "home#save_media", :as => :save_media_to_session

  post "/remove_media_from_session" => "home#remove_media", :as => :remove_media_from_session

  get "/debug_grab_test_urls" => "home#debug_grab_test_urls", :as => :debug_grab_test_urls


  get "/users/:id" => 'users#show', as: :user_home


end
