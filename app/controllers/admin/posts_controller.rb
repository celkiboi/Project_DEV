class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.filter_records(params.to_unsafe_h.slice(:search, :visibility, :date_from, :date_to))
    @posts = @posts.order(publish_date: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(10)
  end
end
