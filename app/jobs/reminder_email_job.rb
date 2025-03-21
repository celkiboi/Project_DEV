class ReminderEmailJob < ApplicationJob
  queue_as :default

  def perform
    cutoff_date = 1.month.ago

    User.where("last_seen_at < ? OR last_seen_at IS NULL", cutoff_date).find_each do |user|
      next if user.reminder_email_sent_at.present? && user.reminder_email_sent_at > cutoff_date

      UserMailer.inactivity_reminder(user).deliver_now
      user.update_column(:reminder_email_sent_at, Time.current)
    end
  end
end
