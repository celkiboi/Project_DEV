class AddUniqueIndexToFollows < ActiveRecord::Migration[7.0]
  def change
    remove_index :follows, column: [:follower_id, :followee_id], if_exists: true
    add_index :follows, [:follower_id, :followee_id], unique: true
  end
end

