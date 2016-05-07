class Blog < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 255 }
  validates :meta_keywords, length: { maximum: 255 }
  validates :meta_description, length: { maximum: 255 }

  class << self
    def instance
      first || new(title: default_title)
    end

    def default_title
      'Okaki'
    end

    private

    def new(attributes)
      # Nothing to do
      super
    end
  end
end
