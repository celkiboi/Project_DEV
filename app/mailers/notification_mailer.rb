class NotificationMailer < ApplicationMailer
  default from: "no-reply@example.com" # Change this to your sender email

  def new_comment(notification)
    @notification = notification
    @comment = notification.notifiable
    @post = @comment.post
    mail(
      to: notification.user.email,
      subject: "New comment on #{@post.title}"
    )
  end

  def new_follower(notification)
    @notification = notification
    @follower = notification.notifiable.follower
    mail(
      to: notification.user.email,
      subject: "New follower"
    )
  end
end
