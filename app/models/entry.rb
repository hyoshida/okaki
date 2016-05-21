class Entry < ActiveRecord::Base
  extend FriendlyId

  friendly_id :slug

  is_impressionable

  SLUG_UNSAFE = /[.!~*';\/#?:@&=+$,\[\] ]/
  SLUG_SEPARATOR = '-'

  belongs_to :user
  belongs_to :category

  scope :recent, -> { order(updated_at: :desc) }

  validates :user, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true
  validates :slug, presence: true, length: { maximum: 255 }

  before_validation :generate_slug, on: :create

  # from DoRuby
  class << self
    def find_by_permalink!(user, date_str, slug)
      date = Date.new(date_str[0, 4].to_i, date_str[4, 2].to_i, date_str[6, 2].to_i)
      user.entries.find_by!('DATE(created_at) = ? AND slug = ?', date, slug)
    end
  end

  def views_count
    impressionist_count
  end

  private

  def generate_slug
    suffix = 0
    slug = title.gsub(SLUG_UNSAFE, SLUG_SEPARATOR)
    slug_with_suffix = slug

    self.slug ||= loop do
      break slug_with_suffix unless self.class.exists?(slug: slug_with_suffix)
      slug_with_suffix = [slug, suffix += 1].join(SLUG_SEPARATOR)
    end
  end
end
