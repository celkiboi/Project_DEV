class AddDetailsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :blocked, :boolean
  end
end
