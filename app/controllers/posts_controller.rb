class PostsController < ApplicationController
  def index
    @posts = [Post.new(:title => "post 1"), Post.new(:title => "post 2")]
  end
end
