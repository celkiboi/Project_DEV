class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.all

    if params[:search].present?
      @posts = @posts.search_by_title_and_summary(params[:search])
    end

    if params[:visibility].present?
      case params[:visibility]
      when "public"
        @posts = @posts.where(public: true)
      when "private"
        @posts = @posts.where(public: false)
      end
    end

    if params[:date_from].present?
      @posts = @posts.where("publish_date >= ?", params[:date_from])
    end

    if params[:date_to].present?
      @posts = @posts.where("publish_date <= ?", params[:date_to])
    end

    @posts = @posts.order(publish_date: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(10)
  end
end
