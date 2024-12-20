class AddUniqueIndexToContactEmails < ActiveRecord::Migration[7.2]
  def change
    add_index :contact_emails, :email, unique: true
  end
end
