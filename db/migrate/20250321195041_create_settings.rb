class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.integer :remind_after_quantity, null: false
      t.string :remind_after_unit, null: false
      t.text :reminder_email_text, null: false

      t.timestamps
    end

    add_check_constraint :settings, "remind_after_unit IN ('days', 'months')", name: "remind_after_unit_check"
  end
end
