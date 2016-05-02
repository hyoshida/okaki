class Entry < ActiveRecord::Base
  belongs_to :user

  scope :recent, -> { order(:updated_at).limit(10) }

  validates :user, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true
end
