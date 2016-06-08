class Tracker < ActiveRecord::Base
  extend Enumerize

  validates :name, presence: true, length: { maximum: 255 }
  validates :tracker_id, length: { maximum: 255 }
  validates :code, presence: true
  validates :location, presence: true

  scope :active, -> { where(active: true) }
  scope :by_newest, -> { reorder(created_at: :desc) }

  enumerize :location, in: %i(
    after_opening_body
    before_closing_body
    head
  ), scope: true

  class << self
    def cache_key
      location = all.where_values_hash['location'] if all.respond_to? :where_values_hash
      maximum_updated_at = maximum(:updated_at)
      timestamp = maximum_updated_at.utc.to_s(cache_timestamp_format) if maximum_updated_at
      "#{model_name.cache_key}/all-#{[location, timestamp, count].compact.join('-')}"
    end
  end
end
