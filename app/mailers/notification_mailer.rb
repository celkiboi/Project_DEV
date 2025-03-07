class NotificationMailer < ApplicationMailer
  default from: "no-reply@example.com"

  def new_comment(notification)
    @notification = notification
    @comment = notification.notifiable
    @post = @comment.post
    mail(
      to: notification.user.email,
      subject: t("mailer.comment.new_comment_on", comment_on: @post.title)
    )
  end

  def new_follower(notification)
    @notification = notification
    @follower = notification.notifiable.follower
    mail(
      to: notification.user.email,
      subject: t("mailer.follow.new_follower")
    )
  end
end
