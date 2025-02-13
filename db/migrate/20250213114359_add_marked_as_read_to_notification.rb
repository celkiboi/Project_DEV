class AddMarkedAsReadToNotification < ActiveRecord::Migration[7.2]
  def change
    add_column :notifications, :markedAsRead, :boolean
  end
end
