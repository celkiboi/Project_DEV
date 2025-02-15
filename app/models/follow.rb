class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"

  validates :follower_id, uniqueness: { scope: :followee_id, message: "You are already following this user." }

  after_create :notify_followee

  private

  def notify_followee
    NotificationJob.perform_later(followee, self)
  end
end
