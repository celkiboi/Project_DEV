class PostsController < ApplicationController
  before_action :set_user, only: [ :user_posts ]
  before_action :authenticate_user!

  def user_posts
    if current_user == @user
      @posts = @user.posts.order(publish_date: :desc).page(params[:page]).per(5)
    elsif current_user
      @posts = @user.posts.published.order(publish_date: :desc).page(params[:page]).per(5)
    else
      @posts = @user.posts.public_posts.order(publish_date: :desc).page(params[:page]).per(5)
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to user_posts_path(current_user)
    else
      flash.now[:alert] =  t("activerecord.errors.messages.record_invalid")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def publish
    @post = Post.find(params[:id])

    if @post.user == current_user
      @post.publish 
      redirect_to user_posts_path(current_user), notice: t('views.posts.user_posts.publish_success')
    else
      redirect_to user_posts_path(current_user), alert: t('views.posts.user_posts.not_author')
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :short_description, :content, :publish_date, :public, :published, :image)
  end
end
