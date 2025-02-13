class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  after_create :notify_post_owner

  private

  def notify_post_owner
    return if post.user == user

    Notification.create!(
      user: post.user,
      notifiable: self,
      marked_as_read: false
    )
  end
end
