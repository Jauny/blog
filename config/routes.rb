Rails.application.routes.draw do
  root :to => "posts#index"

  # Active Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "/lolz", :to => "application#lolz"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, :path => "/", :param => :slug

  # I want to keep former url format from Jekyll to work.
  # Format is /year/slug.
  get "/:year/:slug/", :to => "posts#show", :constraints => { :year => /\d{4}/ }
end
