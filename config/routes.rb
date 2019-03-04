Rails.application.routes.draw do
  root :to => "posts#index"

  # Active Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "/lolz", :to => "application#lolz"
  get "/about", :to => "application#about"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, :path => "/", :param => :slug

  # I want to keep former url format from Jekyll to work.
  # Format is /year/slug.
  get "/2018/migrate-rails-sqlite-postgres-ubuntu", to: redirect("/migrate-rails-5-from-sqlite3-to-postgres-on-ubuntu-16")
  get "/2018/rails-puma-nginx-ubuntu", to: redirect("/automated-deploys-for-rails-5-puma-nginx-ubuntu-16-with-capistrano-on-digital-ocean")
  get "/2017/get-mouse-pos-canvas", to: redirect("/get-mouse-position-on-canvas")
  get "/2017/Google-Eng-Best-Practices", to: redirect("/google-s-software-development-best-practices")
  get "/2017/remove-els-from-slice-while-loop", to: redirect("/removing-elements-from-slice-during-loop")
end
