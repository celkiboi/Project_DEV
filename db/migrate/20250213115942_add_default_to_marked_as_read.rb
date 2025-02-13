class AddDefaultToMarkedAsRead < ActiveRecord::Migration[7.2]
  def change
    change_column_default :notifications, :marked_as_read, false
  end
end
