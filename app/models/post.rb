class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  include PgSearch::Model

  pg_search_scope :search_by_title_and_summary,
    against: [ :title, :short_description ],
    using: { tsearch: { prefix: true } }

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

  def self.filter_records(filters = {})
    result = all
    posts = result.search_by_title_and_summary(filters[:search]) unless filters[:search].blank?
    posts = result.where(public: true) if filters[:visibility] == "public"
    posts = result.where(public: false) if filters[:visibility] == "private"
    posts = posts.where("publish_date >= ?", filters[:date_from]) unless filters[:date_from].blank?
    posts = posts.where("publish_date <= ?", filters[:date_to]) unless filters[:date_to].blank?
    result
  end
end
