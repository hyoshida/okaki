class Navigation < ActiveRecord::Base
  extend Enumerize

  validates :name, presence: true, length: { maximum: 255 }
  validates :url, length: { maximum: 255 }
  validates :location, presence: true

  scope :active, -> { where(active: true) }
  scope :by_newest, -> { reorder(created_at: :desc) }

  enumerize :location, in: %i(
    header
    nav
    footer
  )
end
