Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, :path => "/", :param => :slug

  # I want to keep former url format from Jekyll to work.
  # Format is /year/slug.
  get "/:year/:slug/", :to => "posts#show", :constraints => { :year => /\d{4}/ }

  root :to => "posts#index"
end
