class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :short_description
      t.text :content
      t.string :image
      t.date :publish_date
      t.boolean :public
      t.boolean :published

      t.timestamps
    end
  end
end
