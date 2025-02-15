class NotificationJob < ApplicationJob
  queue_as :default

  def perform(user, notifiable)
    Notification.create!(
      user: user,
      notifiable: notifiable,
      marked_as_read: false
    )
  end
end
