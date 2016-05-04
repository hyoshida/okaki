class Entry < ActiveRecord::Base
  SLUG_UNSAFE = /[.!~*';\/#?:@&=+$,\[\]]/

  belongs_to :user

  scope :recent, -> { order(updated_at: :desc).limit(10) }

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

  def to_param
    slug
  end

  private

  def generate_slug
    suffix = 0
    slug = title.gsub(SLUG_UNSAFE, '_')
    slug_with_suffix = slug

    self.slug ||= loop do
      break slug_with_suffix unless self.class.exists?(slug: slug_with_suffix)
      slug_with_suffix = [slug, suffix += 1].join('_')
    end
  end
end
