class UserMailer < ApplicationMailer
  default from: "no-reply@example.com"

  def inactivity_reminder(user)
    @user = user
    mail(
      to: @user.email,
      subject: "We miss you at OurPlatform!"
    )
  end
end
