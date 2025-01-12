class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts, dependent: :destroy
  has_many :contact_emails, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :contact_emails, allow_destroy: true
  
  validates :name, presence: true
  validates :lastname, presence: true

  mount_uploader :profile_picture, ProfilePictureUploader

  after_initialize :set_default_blocked, if: :new_record?

  has_many :follower_relationships, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :following_relationships, source: :followee

  def has_profile_picture?
    profile_picture.url(:large) != nil
  end

  def following?(user)
    followees.include?(user)
  end

  private

    def set_default_blocked
      self.blocked ||= false
    end
end
