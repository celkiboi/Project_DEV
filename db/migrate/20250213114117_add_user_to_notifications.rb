class AddUserToNotifications < ActiveRecord::Migration[7.2]
  def change
    add_reference :notifications, :user, null: false, foreign_key: true
  end
end
