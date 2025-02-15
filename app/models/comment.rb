class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  after_create :notify_post_owner

  private

  def notify_post_owner
    return if post.user == user

    NotificationJob.perform_later(post.user, self)
  end
end
