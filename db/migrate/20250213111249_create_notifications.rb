class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.references :notifiable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
