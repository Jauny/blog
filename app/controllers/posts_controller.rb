class PostsController < ApplicationController
  def index
    @posts = Post.paginate(:page => params[:page],
                           :per_page => Post::PER_PAGE_COUNT)
                 .order('date DESC')
  end

  def show
    @post = Post.find(params[:id])
  end
end