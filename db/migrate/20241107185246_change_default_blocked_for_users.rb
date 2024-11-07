class ChangeDefaultBlockedForUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :blocked, false
  end
end
