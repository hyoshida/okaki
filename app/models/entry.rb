class Entry < ActiveRecord::Base
  belongs_to :user

  scope :recent, -> { order(:updated_at).limit(10) }

  validates :user, presence: true
end
