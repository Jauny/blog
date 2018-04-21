class PostsController < ApplicationController
  def index
    per_page = 5
    @page = params.fetch("page", 1).to_i
    all_posts = Post.get_all
    start = (@page - 1) * per_page
    stop = start + per_page
    @posts = all_posts[start..stop]
  end

  def show
    @post = Post.find(params[:id])
  end
end
