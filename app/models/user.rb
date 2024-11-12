class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
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
