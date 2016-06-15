class Entry < ActiveRecord::Base
  extend FriendlyId

  friendly_id :slug

  is_impressionable counter_cache: true, unique: :all

  mount_uploader :image, AssetsUploader

  SLUG_UNSAFE = /[.!~*';\/#?:@&=+$,\[\] ]/
  SLUG_SEPARATOR = '-'

  belongs_to :user
  belongs_to :category
  has_many :recommends, dependent: :destroy

  scope :published, -> { where(draft: false) }
  scope :recent, -> { order(updated_at: :desc) }
  scope :newest, -> { order(created_at: :desc).limit(5) }
  scope :most_viewed, -> { order(impressions_count: :desc, created_at: :desc) }
  scope :monthly_most_viewed, -> { most_viewed.where(created_at: [1.month.ago.to_date..Date.today]).limit(5) }

  validates :user, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true
  validates :slug, presence: true, length: { maximum: 255 }

  before_validation :generate_slug, on: :create

  class << self
    def syntax_highlight(html)
      doc = Nokogiri::HTML(html)
      doc.search('pre').each do |pre|
        # Workaround: `lang` can use \w letters. Raise ArgumentError in CodeRay::PluginHost#valudate_id when use not \w letter.
        lang = pre.children.attribute('class').try(:value).to_s.gsub(/[^ \w]/, '_').split(' ').first || :text
        code = CodeRay.scan(pre.inner_html.strip, lang).div
        pre.replace(code)
      end
      doc.to_s.html_safe
    end

    def markdown(text)
      renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
      options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        tables: true
      }
      html = Redcarpet::Markdown.new(renderer, options).render(text)
      syntax_highlight(html).html_safe
    end

    # from DoRuby
    def find_by_permalink!(user, date_str, slug)
      date = Date.new(date_str[0, 4].to_i, date_str[4, 2].to_i, date_str[6, 2].to_i)
      user.entries.published.find_by!('DATE(created_at) = ? AND slug = ?', date, slug)
    end
  end

  def content
    if doruby?
      self.class.syntax_highlight(body)
    else
      self.class.markdown(body)
    end
  end

  def views_count
    impressions_count
  end

  def eye_catch_image_url
    if image?
      image_url
    else
      'noimage.png'
    end
  end

  # for select2
  def as_json(_options = {})
    { id: id, text: title }
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
