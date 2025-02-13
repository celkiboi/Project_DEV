class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :user

  scope :marked_as_read, -> { where(marked_as_read: true) }
  scope :unread, -> { where(marked_as_read: false) }
  scope :recent_first, -> { order(created_at: :desc) }

  def marked_as_read?
    marked_as_read
  end

  def mark_as_read
    update(marked_as_read: true)
  end

  def redirect_path(controller)
    case notifiable
    when Comment
      controller.post_path(notifiable.post, anchor: "comment-#{notifiable.id}")
    when Follow
      controller.user_path(notifiable.follower)
    else
      controller.root_path
    end
  end
end
