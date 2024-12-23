class EnsurePublishDateIsDate < ActiveRecord::Migration[7.2]
  def change
    change_column :posts, :publish_date, :date
  end
end
