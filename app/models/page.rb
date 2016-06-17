class Page < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, use: :slugged

  validates :title, length: { maximum: 255 }, presence: true
  validates :content, presence: true
  validates :slug, length: { maximum: 255 }, presence: true, uniqueness: true

  scope :by_newest, -> { order(created_at: :desc) }

  def normalize_slug(string)
    normalize_friendly_id(string).presence || default_slug
  end

  private

  def default_slug
    id ||= self.class.maximum(:id).try(:next) || 1
    "pages_#{id}"
  end
end
