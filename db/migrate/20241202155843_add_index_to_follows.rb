class AddIndexToFollows < ActiveRecord::Migration[6.1]
  def change
    add_index :follows, [:follower_id, :followee_id], unique: true
  end
end
