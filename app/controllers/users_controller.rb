class UsersController < ApplicationController
  before_action :authenticate_user!

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, contact_emails_attributes: [:id, :email, :_destroy])
  end

  def show
    @user = User.find(params[:id])
    @is_current_user = @user == current_user
    @followers_count = @user.followers.size
    @following_count = @user.followees.size
  end

  def follow
    @user = User.find(params[:id])
    
    if @user == current_user
      flash[:alert] = t('views.users.show.cannot_follow_yourself')
    elsif !current_user.following?(@user)
      current_user.following_relationships.create(followee: @user)
      flash[:notice] = t('views.users.show.followed_successfully')
    else
      flash[:alert] = t('views.users.show.already_following')
    end
  
    redirect_to user_profile_path(@user)
  end  

  def unfollow
    @user = User.find(params[:id])
    current_user.following_relationships.find_by(followee: @user).destroy
    redirect_to user_profile_path(@user)
  end

  def connections
    @user = User.find(params[:id])
    @followers = @user.followers
    @following = @user.followees
  end
end
