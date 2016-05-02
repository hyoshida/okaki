class Entry < ActiveRecord::Base
  SLUG_UNSAFE = /[.!~*';\/#?:@&=+$,\[\]]/

  belongs_to :user

  scope :recent, -> { order(:updated_at).limit(10) }

  validates :user, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true
  validates :slug, presence: true, length: { maximum: 255 }

  before_validation :generate_slug, on: :create

  def to_param
    slug
  end

  private

  def generate_slug
    suffix = 0
    slug = title.gsub(SLUG_UNSAFE, '_')
    slug_with_suffix = slug

    self.slug = loop do
      break slug_with_suffix unless self.class.exists?(slug: slug_with_suffix)
      slug_with_suffix = [slug, suffix += 1].join('_')
    end
  end
end
