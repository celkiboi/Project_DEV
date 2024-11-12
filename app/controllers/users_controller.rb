class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @is_current_user = @user == current_user
    @followers_count = @user.followers.count
    @following_count = @user.followees.size
  end

  def follow
    @user = User.find(params[:id])
    current_user.following_relationships.create(followee: @user) unless current_user.following?(@user)
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
