class Navigation < ActiveRecord::Base
  extend Enumerize

  validates :name, presence: true, length: { maximum: 255 }
  validates :url, length: { maximum: 255 }
  validates :location, presence: true

  scope :active, -> { where(active: true) }
  scope :by_newest, -> { reorder(created_at: :desc) }

  default_scope -> { order(:position) }

  acts_as_list scope: [:location]

  enumerize :location, in: %i(
    header
    nav
    footer
  )

  class << self
    def cache_key
      location = all.where_values_hash['location'] if all.respond_to? :where_values_hash
      page = all.current_page if all.respond_to? :current_page
      maximum_updated_at = maximum(:updated_at)
      timestamp = maximum_updated_at.utc.to_s(cache_timestamp_format) if maximum_updated_at
      "#{model_name.cache_key}/all-#{[location, page, timestamp, count].compact.join('-')}"
    end
  end
end
