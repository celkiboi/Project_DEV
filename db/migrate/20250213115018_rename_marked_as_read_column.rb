class RenameMarkedAsReadColumn < ActiveRecord::Migration[7.2]
  def change
    rename_column :notifications, :markedAsRead, :marked_as_read
  end
end
