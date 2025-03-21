class UserMailer < ApplicationMailer
  def inactivity_reminder(user, custom_text)
    @user = user
    @custom_text = custom_text

    mail(to: @user.email, subject: "We miss you!") do |format|
      format.text { render plain: @custom_text }
      format.html { render html: "<p>#{@custom_text}</p>".html_safe }
    end
  end
end
