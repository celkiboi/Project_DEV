class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"

  validates :follower_id, uniqueness: { scope: :followee_id, message: "You are already following this user." }

  after_create :notify_followee

  private

  def notify_followee
    Notification.create!(
      user: followee,
      notifiable: self,
      marked_as_read: false
    )
  end
end
