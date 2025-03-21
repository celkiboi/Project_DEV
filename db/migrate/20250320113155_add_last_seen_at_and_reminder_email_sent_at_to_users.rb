class AddLastSeenAtAndReminderEmailSentAtToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :last_seen_at, :datetime
    add_column :users, :reminder_email_sent_at, :datetime
  end
end
