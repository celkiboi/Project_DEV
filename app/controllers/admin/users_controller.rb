class Admin::UsersController < Admin::BaseController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @followers_count = @user.followers.size
    @following_count = @user.followees.size
  end

  def posts
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10)
  end
end
