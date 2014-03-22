  FreeCandy::Application.routes.draw do
  devise_for :users
  resources :users, :only => :show
  resources :videos, :only => :show
  resources :pictures, :only => :show

  root to: 'home#index'
  get 'editor/home', :to => 'editor#home'
  get 'editor/renderIO', :to => 'editor#renderStatus'
  post 'editor/renderIO', :to => 'editor#renderCommand'

  match 'search', to: 'home#search', via: :get
  match 'popular', to: 'home#popular', via: :get
  match 'display', to: 'home#display', via: :get
  match 'recently_created_media', to: 'home#recent_media', via: :get

  get '/home/show' => 'home#show', as: :home
  post "/save_media_to_session" => "home#save_media", :as => :save_media_to_session
  post "/remove_media_from_session" => "home#remove_media", :as => :remove_media_from_session
  get "/debug_grab_test_urls" => "home#debug_grab_test_urls", :as => :debug_grab_test_urls
end
