class PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(Post::PER_PAGE_COUNT).order('date DESC')
  end

  def show
    @post = Post.find_by(:slug => params[:slug])
  end
end
