class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  attribute :publish_date, default: Date.current

  validates :title, presence: true
  validates :short_description, presence: true
  validates :content, presence: true
  validates :publish_date, presence: true

  mount_uploader :image, PostImageUploader

  scope :published, -> { where(published: true).where("publish_date <= ?", Date.today) }
  scope :public_posts, -> { published.where(public: true) }

  def published?
    published && publish_date <= Date.today
  end

  def has_image?
    image.present?
  end

  def publish
    update(published: true)
  end
end
