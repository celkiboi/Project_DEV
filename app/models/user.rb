class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true
  validates :lastname, presence: true

  mount_uploader :profile_picture, ProfilePictureUploader

  after_initialize :set_default_blocked, if: :new_record?

  def has_profile_picture?
    profile_picture.url(:large) != nil
  end

  private

    def set_default_blocked
      self.blocked ||= false
    end
end
