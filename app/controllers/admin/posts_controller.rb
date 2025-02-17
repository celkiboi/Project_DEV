class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(10)
  end
end
