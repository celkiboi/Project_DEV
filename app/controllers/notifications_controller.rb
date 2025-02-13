class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: [ :show ]

  def index
    @notifications = current_user.notifications.recent_first
  end

  def show
    @notification.mark_as_read
    redirect_to @notification.redirect_path(self)
  end

  private

  def set_notification
    @notification = current_user.notifications.find(params[:id])
  end
end
