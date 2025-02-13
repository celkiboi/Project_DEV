class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  has_one :user

  scope :marked_as_read, -> { where(markedAsRead: true) }

  def marked_as_read?
    markedAsRead
  end

  def mark_as_read
    update(markedAsRead: true)
  end
end
