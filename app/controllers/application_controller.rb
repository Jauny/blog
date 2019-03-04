class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def lolz
    render "lolz/index"
  end

  def about
    render "about/index"
  end
end
